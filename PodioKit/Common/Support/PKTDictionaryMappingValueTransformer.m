//
//  PKTDictionaryMappingValueTransformer.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTDictionaryMappingValueTransformer.h"

@interface PKTDictionaryMappingValueTransformer ()

@property (nonatomic, copy) NSDictionary *mappingDictionary;
@property (nonatomic, copy, readonly) NSDictionary *reverseMappingDictionary;

@end

@implementation PKTDictionaryMappingValueTransformer

@synthesize reverseMappingDictionary = _reverseMappingDictionary;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
  self = [super init];
  if (!self) return nil;
  
  _mappingDictionary = [dictionary copy];
  
  return self;
}

+ (instancetype)transformerWithDictionary:(NSDictionary *)dictionary {
  return [[self alloc] initWithDictionary:dictionary];
}

#pragma mark - Properties

- (NSDictionary *)reverseMappingDictionary {
  if (!_reverseMappingDictionary) {
    NSMutableDictionary *mutReverseDictionary = [NSMutableDictionary dictionary];
    [self.mappingDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
      if ([obj conformsToProtocol:@protocol(NSCopying)]) {
        mutReverseDictionary[obj] = key;
      }
    }];
    
    _reverseMappingDictionary = [mutReverseDictionary copy];
  }
  
  return _reverseMappingDictionary;
}

#pragma mark - NSValueTransformer

+ (BOOL)allowsReverseTransformation {
  return YES;
}

- (id)transformedValue:(id)value {
  return self.mappingDictionary[value];
}

- (id)reverseTransformedValue:(id)value {
  return self.reverseMappingDictionary[value];
}

@end
