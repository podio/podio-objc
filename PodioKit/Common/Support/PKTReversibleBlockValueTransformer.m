//
//  PKTReversibleBlockValueTransformer.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTReversibleBlockValueTransformer.h"

@interface PKTReversibleBlockValueTransformer ()

@property (nonatomic, copy) PKTValueTransformationBlock reverseBlock;

@end

@implementation PKTReversibleBlockValueTransformer

- (instancetype)init {
  return [self initWithBlock:nil reverseBlock:nil];
}

- (instancetype)initWithBlock:(PKTValueTransformationBlock)block reverseBlock:(PKTValueTransformationBlock)reverseBlock {
  self = [super initWithBlock:block];
  if (!self) return nil;
  
  _reverseBlock = [reverseBlock copy];
  
  return self;
}

+ (instancetype)transformerWithBlock:(PKTValueTransformationBlock)block reverseBlock:(PKTValueTransformationBlock)reverseBlock {
  return [[self alloc] initWithBlock:block reverseBlock:reverseBlock];
}

#pragma mark - NSValueTransformer

+ (BOOL)allowsReverseTransformation {
  return YES;
}

- (id)reverseTransformedValue:(id)value {
  return self.reverseBlock ? self.reverseBlock(value) : nil;
}

@end
