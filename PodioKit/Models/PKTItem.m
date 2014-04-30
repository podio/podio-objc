//
//  PKTItem.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 31/03/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTItem.h"
#import "PKTItemField.h"
#import "PKTFile.h"
#import "PKTComment.h"
#import "PKTApp.h"
#import "PKTItemAPI.h"
#import "PKTResponse.h"
#import "NSValueTransformer+PKTTransformers.h"
#import "PKTMacros.h"

@interface PKTItem ()

@property (nonatomic, assign) NSUInteger itemID;
@property (nonatomic, strong) NSMutableArray *mutFields;
@property (nonatomic, strong, readonly) NSMutableDictionary *unsavedFields;
@property (nonatomic, copy, readonly) NSArray *fileIDs;

@end

@implementation PKTItem

@synthesize mutFields = _mutFields;
@synthesize unsavedFields = _unsavedFields;

- (instancetype)initWithAppID:(NSUInteger)appID {
  self = [super init];
  if (!self) return nil;
    
  _appID = appID;
    
  return self;
}

+ (instancetype)itemForAppWithID:(NSUInteger)appID {
  return [[self alloc] initWithAppID:appID];
}

#pragma mark - Properties

- (NSArray *)fields {
  return [self.mutFields copy];
}

- (NSArray *)fileIDs {
  return [self.files valueForKey:@"fileID"];
}

- (NSMutableDictionary *)unsavedFields {
  if (!_unsavedFields) {
    _unsavedFields = [NSMutableDictionary new];
  }
  
  return _unsavedFields;
}

- (NSMutableArray *)mutFields {
  if (!_mutFields) {
    _mutFields = [NSMutableArray new];
  }
  
  return _mutFields;
}

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"itemID": @"item_id",
    @"appID": @"app.app_id",
    @"mutFields": @"fields",
    @"files": @"files",
    @"comments": @"comments"
  };
}

+ (NSValueTransformer *)mutFieldsValueTransformer {
  return [NSValueTransformer pkt_transformerWithBlock:^id(NSArray *values) {
    NSMutableArray *mutFields = [NSMutableArray new];
    
    for (NSDictionary *value in values) {
      PKTItemField *field = [[PKTItemField alloc] initWithDictionary:value];
      [mutFields addObject:field];
    }
    
    return mutFields;
  }];
}

+ (NSValueTransformer *)filesValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTFile class]];
}

+ (NSValueTransformer *)commentsValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTComment class]];
}

#pragma mark - API

+ (void)performRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  [self.client performRequest:request completion:completion];
}

+ (void)fetchItemWithID:(NSUInteger)itemID completion:(void (^)(PKTItem *item, NSError *error))completion {
  PKTRequest *request = [PKTItemAPI requestForItemWithID:itemID];
  
  [self performRequest:request completion:^(PKTResponse *response, NSError *error) {
    PKTItem *item = nil;
    if (!error) {
      item = [[PKTItem alloc] initWithDictionary:response.body];
    }
    
    if (completion) completion(item, error);
  }];
}

- (void)saveWithCompletion:(PKTRequestCompletionBlock)completion {
  PKT_WEAK_SELF weakSelf = self;
  
  [PKTApp fetchAppWithID:self.appID completion:^(PKTApp *app, NSError *error) {
    PKT_STRONG(weakSelf) strongSelf = weakSelf;
    
    if (!error) {
      NSArray *itemFields = [strongSelf allFieldsToSaveForApp:app error:&error];
      if (!error) {
        [strongSelf saveWithItemFields:itemFields completion:completion];
      } else {
        if (completion) completion(nil, error);
      }
    } else {
      if (completion) completion(nil, error);
    }
  }];
}

- (void)saveWithItemFields:(NSArray *)itemFields completion:(PKTRequestCompletionBlock)completion {
  NSDictionary *fields = [self preparedFieldValuesForItemFields:itemFields];
  NSArray *files = self.fileIDs;
  
  PKTRequest *request = nil;
  if (self.itemID == 0) {
    request = [PKTItemAPI requestToCreateItemInAppWithID:self.appID
                                                  fields:fields
                                                   files:files
                                                    tags:nil];
  } else {
    request = [PKTItemAPI requestToUpdateItemWithID:self.itemID
                                             fields:fields
                                              files:files
                                               tags:nil];
  }
  
  PKT_WEAK_SELF weakSelf = self;
  [[self class] performRequest:request completion:^(PKTResponse *response, NSError *error) {
    PKT_STRONG(weakSelf) strongSelf = weakSelf;
    
    if (!error) {
      strongSelf.itemID = [response.body[@"item_id"] unsignedIntegerValue];
      
      // Update with the newly saved fields
      strongSelf.mutFields = [itemFields mutableCopy];
    }
    
    if (completion) completion(response, error);
  }];
}

#pragma mark - Public

- (void)setValue:(id)value forField:(NSString *)externalID {
  NSParameterAssert(value);
  NSParameterAssert(externalID);
  
  PKTItemField *field = [self fieldForExternalID:externalID];
  if (field) {
    [field setFirstValue:value];
  } else {
    [self setValue:value forUnsavedFieldWithExternalID:externalID];
  }
}

- (id)valueForField:(NSString *)externalID {
  NSParameterAssert(externalID);
  
  id value = nil;
  
  PKTItemField *field = [self fieldForExternalID:externalID];
  if (field) {
    value = [field firstValue];
  } else {
    value = [self valueForUnsavedFieldWithExternalID:externalID];
  }
  
  return value;
}

#pragma mark - Private

/**
 * Joins the existing and unsaved fields into an array of PKTItemField objects, using the provided
 * app's fields as the template for the unsaved fields.
 */
- (NSArray *)allFieldsToSaveForApp:(PKTApp *)app error:(NSError **)error {
  NSArray *fields = nil;
  
  NSArray *unsavedItemFields = [self itemFieldsFromUnsavedFields:self.unsavedFields forApp:app error:error];
  if (!error) {
    NSMutableArray *mutFields = [self.mutFields mutableCopy];
    [mutFields addObjectsFromArray:unsavedItemFields];
    fields = [self.mutFields copy];
  }
  
  return fields;
}

/**
 * Converts the 'unsavedFields' dictionary of externalID => value into an array of PKItemField objects, using the provided
 * app's fields as the template for the unsaved fields.
 *
 * @param usavedFields an NSDictionary with the external ID as the key, and an array of values as the value
 */
- (NSArray *)itemFieldsFromUnsavedFields:(NSDictionary *)unsavedFields forApp:(PKTApp *)app error:(NSError **)error {
  // TODO: Generate error for invalid fields
  
  NSMutableArray *validFields = [NSMutableArray new];
  
  [unsavedFields enumerateKeysAndObjectsUsingBlock:^(NSString *externalID, id value, BOOL *stop) {
    PKTAppField *appField = [app fieldWithExternalID:externalID];
    
    if (appField) {
      NSArray *values = [value isKindOfClass:[NSArray class]] ? value : @[value];
      PKTItemField *field = [[PKTItemField alloc] initWithAppField:appField values:values];
      [validFields addObject:field];
    }
  }];
  
  return [validFields copy];
}

- (PKTItemField *)fieldForExternalID:(NSString *)externalID {
  __block PKTItemField *field = nil;

  [self.fields enumerateObjectsUsingBlock:^(PKTItemField *currentField, NSUInteger idx, BOOL *stop) {
    if ([currentField.externalID isEqualToString:externalID]) {
      field = currentField;
      *stop = YES;
    }
  }];
  
  return field;
}

- (id)valueForUnsavedFieldWithExternalID:(NSString *)externalID {
  return [self.unsavedFields objectForKey:externalID];
}

- (void)setValue:(id)value forUnsavedFieldWithExternalID:(NSString *)externalID {
  [self.unsavedFields setObject:value forKey:externalID];
}

- (NSDictionary *)preparedFieldValuesForItemFields:(NSArray *)fields {
  NSMutableDictionary *mutFieldValues = [NSMutableDictionary new];
  for (PKTItemField *field in fields) {
    mutFieldValues[field.externalID] = [field preparedValues];
  }
  
  return [mutFieldValues copy];
}

#pragma mark - Subscripting support

- (id)objectForKeyedSubscript:(id <NSCopying>)key {
  return [self valueForField:(NSString *)key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key {
  [self setValue:obj forField:(NSString *)key];
}

@end
