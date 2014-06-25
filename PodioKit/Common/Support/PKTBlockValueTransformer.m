//
//  PKTBlockValueTransformer.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBlockValueTransformer.h"

@interface PKTBlockValueTransformer ()

@property (nonatomic, copy) PKTValueTransformationBlock transformBlock;

@end

@implementation PKTBlockValueTransformer

- (instancetype)init {
  return [self initWithBlock:nil];
}

- (instancetype)initWithBlock:(PKTValueTransformationBlock)block {
  self = [super init];
  if (!self) return nil;
  
  _transformBlock = [block copy];
  
  return self;
}

+ (instancetype)transformerWithBlock:(PKTValueTransformationBlock)block {
  return [[self alloc] initWithBlock:block];
}

#pragma mark - NSValueTransformer

+ (BOOL)allowsReverseTransformation {
  return NO;
}

- (id)transformedValue:(id)value {
  return self.transformBlock ? self.transformBlock(value) : nil;
}

@end
