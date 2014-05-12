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
#import "PKTByLine.h"
#import "PKTItemAPI.h"
#import "PKTResponse.h"
#import "NSValueTransformer+PKTTransformers.h"
#import "NSArray+PKTAdditions.h"

@interface PKTItem ()

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSMutableArray *mutFields;
@property (nonatomic, strong, readonly) NSMutableDictionary *unsavedFields;
@property (nonatomic, strong, readonly) NSMutableArray *mutFiles;
@property (nonatomic, copy, readonly) NSArray *fileIDs;

@end

@implementation PKTItem

@synthesize mutFields = _mutFields;
@synthesize mutFiles = _mutFiles;
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

- (NSArray *)files {
  return [self.mutFiles copy];
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

- (NSMutableArray *)mutFiles {
  if (!_mutFiles) {
    _mutFiles = [NSMutableArray new];
  }
  
  return _mutFiles;
}

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"itemID": @"item_id",
    @"appID": @"app.app_id",
    @"appItemID" : @"app_item_id",
    @"createdOn" : @"created_on",
    @"createdBy" : @"created_by",
    @"mutFields": @"fields",
    @"mutFiles": @"files",
    @"comments": @"comments"
  };
}

+ (NSValueTransformer *)createdOnValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)createdByValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTByLine class]];
}

+ (NSValueTransformer *)appValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTApp class]];
}

+ (NSValueTransformer *)mutFieldsValueTransformer {
  return [NSValueTransformer pkt_transformerWithBlock:^id(NSArray *values) {
    return [[values pkt_mappedArrayWithBlock:^id(NSDictionary *itemDict) {
      return [[PKTItemField alloc] initWithDictionary:itemDict];
    }] mutableCopy];
  }];
}

+ (NSValueTransformer *)mutFilesValueTransformer {
  return [NSValueTransformer pkt_transformerWithBlock:^id(NSArray *values) {
    return [[values pkt_mappedArrayWithBlock:^id(NSDictionary *itemDict) {
      return [[PKTFile alloc] initWithDictionary:itemDict];
    }] mutableCopy];
  }];
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

+ (void)fetchItemsInAppWithID:(NSUInteger)appID offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(PKTItemFilteredFetchCompletionBlock)completion {
  [self fetchItemsInAppWithID:appID offset:offset limit:limit sortBy:nil descending:YES completion:completion];
}

+ (void)fetchItemsInAppWithID:(NSUInteger)appID offset:(NSUInteger)offset limit:(NSUInteger)limit sortBy:(NSString *)sortBy descending:(BOOL)descending completion:(PKTItemFilteredFetchCompletionBlock)completion; {
  PKTRequest *request = [PKTItemAPI requestForFilteredItemsInAppWithID:appID
                                                                offset:offset
                                                                 limit:limit
                                                                sortBy:sortBy
                                                            descending:descending
                                                              remember:NO];
  
  [self fetchFilteredItemsWithRequest:request completion:completion];
}

+ (void)fetchItemsInAppWithID:(NSUInteger)appID offset:(NSUInteger)offset limit:(NSUInteger)limit viewID:(NSUInteger)viewID completion:(PKTItemFilteredFetchCompletionBlock)completion {
  PKTRequest *request = [PKTItemAPI requestForFilteredItemsInAppWithID:appID
                                                                offset:offset
                                                                 limit:limit
                                                                viewID:viewID
                                                              remember:NO];

  [self fetchFilteredItemsWithRequest:request completion:completion];
}

+ (void)fetchFilteredItemsWithRequest:(PKTRequest *)request completion:(PKTItemFilteredFetchCompletionBlock)completion {
  [self performRequest:request completion:^(PKTResponse *response, NSError *error) {
    NSArray *items = nil;
    NSUInteger filteredCount = 0, totalCount = 0;

    if (!error) {
      filteredCount = [response.body[@"filtered"] unsignedIntegerValue];
      totalCount = [response.body[@"total"] unsignedIntegerValue];
      NSArray *itemDicts = response.body[@"items"];

      items = [itemDicts pkt_mappedArrayWithBlock:^id(NSDictionary *itemDict) {
        return [[PKTItem alloc] initWithDictionary:itemDict];
      }];
    }

    if (completion) completion(items, filteredCount, totalCount, error);
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

- (void)addFile:(PKTFile *)file {
  NSParameterAssert(file);
  [self.mutFiles addObject:file];
}

- (void)removeFileWithID:(NSUInteger)fileID {
  PKTFile *file = [self.mutFiles pkt_firstObjectPassingTest:^BOOL(PKTFile *file) {
    return file.fileID == fileID;
  }];
  
  if (file) {
    [self.mutFiles removeObject:file];
  }
}

#pragma mark - Private

- (PKTItemField *)fieldForExternalID:(NSString *)externalID {
  return [self.fields pkt_firstObjectPassingTest:^BOOL(PKTItemField *currentField) {
    return [currentField.externalID isEqualToString:externalID];
  }];
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
