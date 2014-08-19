//
//  PKTReferenceIdentifier.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTReferenceIdentifier.h"
#import "NSValueTransformer+PKTConstants.h"

@implementation PKTReferenceIdentifier

- (instancetype)init {
  return [self initWithReferenceID:0 type:PKTReferenceTypeUnknown];
}

- (instancetype)initWithReferenceID:(NSUInteger)referenceID type:(PKTReferenceType)referenceType {
  self = [super init];
  if (!self) return nil;
  
  _referenceID = referenceID;
  _referenceType = referenceType;
  
  return self;
}

+ (instancetype)identifierWithReferenceID:(NSUInteger)referenceID type:(PKTReferenceType)referenceType {
  return [[self alloc] initWithReferenceID:referenceID type:referenceType];
}

#pragma mark - NSCopying

- (instancetype)copyWithZone:(NSZone *)zone {
  return [[[self class] alloc] initWithReferenceID:self.referenceID type:self.referenceType];
}

#pragma mark - Properties

- (NSString *)referenceTypeString {
  return [NSValueTransformer pkt_stringFromReferenceType:self.referenceType];
}

@end
