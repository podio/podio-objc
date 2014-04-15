//
//  PKTItem.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 31/03/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTItem.h"
#import "PKTItemAPI.h"

@interface PKTItem ()

@property (nonatomic, strong) NSMutableDictionary *mutFields;

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

- (NSMutableDictionary *)mutFields {
  if (!_mutFields) {
    _mutFields = [NSMutableDictionary new];
  }
  
  return _mutFields;
}

- (NSDictionary *)fields {
  return [self.mutFields copy];
}

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"itemID": @"item_id"
  };
}

#pragma mark - Public

+ (void)performRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  [self.client performRequest:request completion:completion];
}

+ (void)fetchItemWithID:(NSUInteger)itemID completion:(PKTRequestCompletionBlock)completion {
  PKTRequest *request = [PKTItemAPI requestForItemWithID:itemID];
  [self performRequest:request completion:completion];
}

- (void)saveWithCompletion:(PKTRequestCompletionBlock)completion {
  PKTRequest *request = nil;
  
  if (self.itemID == 0) {
    request = [PKTItemAPI requestToCreateItemInAppWithID:self.appID
                                                  fields:nil
                                                   files:nil
                                                    tags:nil];
  } else {
    request = [PKTItemAPI requestToUpdateItemWithID:self.itemID
                                                  fields:nil
                                                   files:nil
                                                    tags:nil];
  }
  
  [[self class] performRequest:request completion:completion];
}

#pragma mark - Subscripting support

- (id)objectForKeyedSubscript:(id <NSCopying>)key {
  return self.mutFields[key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key {
  NSParameterAssert(key);
  self.mutFields[key] = obj;
}

@end
