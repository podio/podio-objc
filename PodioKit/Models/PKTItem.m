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

@interface PKTItem ()

@property (nonatomic, copy) NSString *title;
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
  [PKTApp fetchAppWithID:self.appID completion:^(PKTApp *app, NSError *error) {
    if (!error) {
      NSArray *itemFields = [self allFieldsToSaveForApp:app];
      if (!error) {
        [self saveWithItemFields:itemFields completion:completion];
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
  
  [[self class] performRequest:request completion:^(PKTResponse *response, NSError *error) {
    if (!error) {
      if (self.itemID == 0) {
        // Item created, update fully from response
        [self updateFromDictionary:response.body];
      } else {
        // Item updated, set the new title returned
        self.title = response.body[@"title"];
        
        // Just update the fields since the response doesn't contain the full object
        self.mutFields = [itemFields mutableCopy];
      }
      
      [self.unsavedFields removeAllObjects];
    }
    
    if (completion) completion(response, error);
  }];
}

#pragma mark - Public

- (id)valueForField:(NSString *)externalID {
  return [[self valuesForField:externalID] firstObject];
}

- (void)setValue:(id)value forField:(NSString *)externalID {
  NSParameterAssert(value);
  [self setValues:@[value] forField:externalID];
}

- (NSArray *)valuesForField:(NSString *)externalID {
  NSParameterAssert(externalID);

  NSArray *values = nil;
  
  PKTItemField *field = [self fieldForExternalID:externalID];
  if (field) {
    values = [field values];
  } else {
    values = [self valuesForUnsavedFieldWithExternalID:externalID];
  }
  
  return values;
}

- (void)setValues:(NSArray *)values forField:(NSString *)externalID {
  NSParameterAssert(externalID);
  
  PKTItemField *field = [self fieldForExternalID:externalID];
  if (field) {
    [field setValues:values];
  } else {
    [self setValues:values forUnsavedFieldWithExternalID:externalID];
  }
}

- (void)addValue:(id)value forField:(NSString *)externalID {
  NSParameterAssert(externalID);
  
  PKTItemField *field = [self fieldForExternalID:externalID];
  if (field) {
    [field addValue:value];
  } else {
    [self addValue:value forUnsavedFieldWithExternalID:externalID];
  }
}

- (void)removeValue:(id)value forField:(NSString *)externalID {
  NSParameterAssert(externalID);
  
  PKTItemField *field = [self fieldForExternalID:externalID];
  if (field) {
    [field removeValue:value];
  } else {
    [self removeValue:value forUnsavedFieldWithExternalID:externalID];
  }
}

- (void)removeValueAtIndex:(NSUInteger)index forField:(NSString *)externalID {
  NSParameterAssert(externalID);
  
  PKTItemField *field = [self fieldForExternalID:externalID];
  if (field) {
    [field removeValueAtIndex:index];
  } else {
    [self removeValueAtIndex:index forUnsavedFieldWithExternalID:externalID];
  }
}

#pragma mark - Private

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

/**
 * Joins the existing and unsaved fields into an array of PKTItemField objects, using the provided
 * app's fields as the template for the unsaved fields.
 */
- (NSArray *)allFieldsToSaveForApp:(PKTApp *)app {
  NSArray *fields = nil;
  
  NSArray *unsavedItemFields = [self itemFieldsFromUnsavedFields:self.unsavedFields forApp:app];
  
  NSMutableArray *mutFields = [self.mutFields mutableCopy];
  [mutFields addObjectsFromArray:unsavedItemFields];
  fields = [mutFields copy];
  
  return fields;
}

/**
 * Converts the 'unsavedFields' dictionary of externalID => value into an array of PKItemField objects, using the provided
 * app's fields as the template for the unsaved fields.
 *
 * @param usavedFields an NSDictionary with the external ID as the key, and an array of values as the value
 */
- (NSArray *)itemFieldsFromUnsavedFields:(NSDictionary *)unsavedFields forApp:(PKTApp *)app {
  // TODO: Generate error for invalid fields
  
  NSMutableArray *validFields = [NSMutableArray new];
  
  [unsavedFields enumerateKeysAndObjectsUsingBlock:^(NSString *externalID, id value, BOOL *stop) {
    PKTAppField *appField = [app fieldWithExternalID:externalID];
    
    if (appField) {
      NSArray *values = [value isKindOfClass:[NSArray class]] ? value : @[value];
      for (id value in values) {
        
        NSError *error = nil;
        if (![PKTItemField isSupportedValue:value forFieldType:appField.type error:&error]) {
          NSString *reason = [NSString stringWithFormat:@"Invalid field value: %@", [error localizedDescription]];
          NSException *exception = [NSException exceptionWithName:@"InvalidFieldValueException" reason:reason userInfo:nil];
          
          @throw exception;
        }
      }
      
      PKTItemField *field = [[PKTItemField alloc] initWithAppField:appField values:values];
      [validFields addObject:field];
    } else {
      NSString *reason = [NSString stringWithFormat:@"No app field exists with external ID '%@'.", externalID];
      NSException *exception = [NSException exceptionWithName:@"NoSuchAppFieldException" reason:reason userInfo:nil];
      
      @throw exception;
    }
  }];
  
  return [validFields copy];
}

- (NSArray *)valuesForUnsavedFieldWithExternalID:(NSString *)externalID {
  return [self.unsavedFields objectForKey:externalID];
}

- (void)setValues:(NSArray *)values forUnsavedFieldWithExternalID:(NSString *)externalID {
  [self.unsavedFields setObject:values forKey:externalID];
}

- (void)addValue:(id)value forUnsavedFieldWithExternalID:(NSString *)externalID {
  NSMutableArray *values = [[self valuesForUnsavedFieldWithExternalID:externalID] mutableCopy];
  if (!values) {
    values = [NSMutableArray new];
  }
  
  [values addObject:value];
  
  [self setValues:[values copy] forUnsavedFieldWithExternalID:externalID];
}

- (void)removeValue:(id)value forUnsavedFieldWithExternalID:(NSString *)externalID {
  NSMutableArray *values = [[self valuesForUnsavedFieldWithExternalID:externalID] mutableCopy];
  if (!values) {
    values = [NSMutableArray new];
  }
  
  [values removeObject:value];
  
  [self setValues:[values copy] forUnsavedFieldWithExternalID:externalID];
}

- (void)removeValueAtIndex:(NSUInteger)index forUnsavedFieldWithExternalID:(NSString *)externalID {
  NSMutableArray *values = [[self valuesForUnsavedFieldWithExternalID:externalID] mutableCopy];
  if (!values) {
    values = [NSMutableArray new];
  }
  
  [values removeObjectAtIndex:index];
  
  [self setValues:[values copy] forUnsavedFieldWithExternalID:externalID];
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
