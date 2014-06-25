//
//  PKTModelValueTransformer.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 15/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModelValueTransformer.h"
#import "PKTModel.h"

@interface PKTModelValueTransformer ()

@property (nonatomic, strong) Class modelClass;

@end

@implementation PKTModelValueTransformer

- (instancetype)init {
  return [self initWithModelClass:nil];
}

- (instancetype)initWithModelClass:(Class)modelClass {
  self = [super init];
  if (!self) return nil;
  
  NSParameterAssert([modelClass isSubclassOfClass:[PKTModel class]]);
  _modelClass = modelClass;
  
  return self;
}

+ (instancetype)transformerWithModelClass:(Class)modelClass {
  return [[self alloc] initWithModelClass:modelClass];
}

#pragma mark - NSValueTransformer

- (id)transformedValue:(id)value {
  id transformedValue = nil;
  
  if ([value isKindOfClass:[NSArray class]]) {
    // Many objects
    NSArray *objects = value;
    
    NSMutableArray *modelObjects = [NSMutableArray array];
    
    for (id dict in objects) {
      if ([dict isKindOfClass:[NSDictionary class]]) {
        id modelObject = [self modelObjectFromDictionary:dict];
        if (modelObject) {
          [modelObjects addObject:modelObject];
        }
      }
    }
    
    transformedValue = [modelObjects copy];
  } else if ([value isKindOfClass:[NSDictionary class]]) {
    // Single object
    transformedValue = [self modelObjectFromDictionary:value];
  }
  
  return transformedValue;
}

- (id)modelObjectFromDictionary:(NSDictionary *)dictionary {
  return [[self.modelClass alloc] initWithDictionary:dictionary];
}

@end
