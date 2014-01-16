//
//  PKAttributeMapping.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/26/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKAttributeMapping.h"

@implementation PKAttributeMapping

@synthesize attributePathComponents = attributePathComponents_;

- (id)initWithAttributePathComponents:(NSArray *)attributePathComponents {
  self = [super init];
  if (self) {
    attributePathComponents_ = attributePathComponents;
  }
  return self;
}

- (id)initWithAttributeName:(NSString *)attributeName {
  NSArray *components = [attributeName componentsSeparatedByString:@"/"];
  return [self initWithAttributePathComponents:components];
}


+ (id)mappingForAttributePathComponents:(NSArray *)attributePathComponents {
  return [[self alloc] initWithAttributePathComponents:attributePathComponents];
}

+ (id)mappingForAttributeName:(NSString *)attributeName {
  return [[self alloc] initWithAttributeName:attributeName];
}

- (NSString *)attributePathComponentsString {
  return [self.attributePathComponents componentsJoinedByString:@"/"];
}

@end
