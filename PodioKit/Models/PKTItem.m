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
#import "PKTItemAPI.h"
#import "PKTResponse.h"
#import "NSValueTransformer+PKTTransformers.h"

@interface PKTItem ()

@property (nonatomic, copy, readonly) NSArray *fileIDs;

@end

@implementation PKTItem

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

- (NSArray *)fileIDs {
  return [self.files valueForKey:@"fileID"];
}

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"itemID": @"item_id",
    @"appID": @"app.app_id",
    @"fields": @"fields",
    @"files": @"files",
    @"comments": @"comments"
  };
}

+ (NSValueTransformer *)fieldsValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTItemField class]];
}

+ (NSValueTransformer *)filesValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTFile class]];
}

+ (NSValueTransformer *)commentsValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTComment class]];
}

#pragma mark - Public

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
  PKTRequest *request = nil;
  
  NSDictionary *fields = [self preparedFieldValues];
  NSArray *files = self.fileIDs;
  
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
  
  [[self class] performRequest:request completion:completion];
}

#pragma mark - Private

- (PKTItemField *)fieldForExternalID:(NSString *)externalID {
  PKTItemField *field = nil;
  
  for (PKTItemField *currentField in self.fields) {
    if ([currentField.externalID isEqualToString:externalID]) {
      field = currentField;
    }
  }
  
  return field;
}

- (NSDictionary *)preparedFieldValues {
  NSMutableDictionary *mutFieldValues = [NSMutableDictionary new];
  for (PKTItemField *field in self.fields) {
    mutFieldValues[field.externalID] = [field preparedValues];
  }
  
  return [mutFieldValues copy];
}

#pragma mark - Subscripting support

- (id)objectForKeyedSubscript:(id <NSCopying>)key {
  NSParameterAssert(key);
  
  NSString *externalID = (NSString *)key;
  PKTItemField *field = [self fieldForExternalID:externalID];
  
  return [field firstValue];
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key {
  NSParameterAssert(obj);
  NSParameterAssert(key);
  
  NSString *externalID = (NSString *)key;
  PKTItemField *field = [self fieldForExternalID:externalID];
  
  [field setFirstValue:obj];
}

@end
