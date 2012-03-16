//
//  PKPropertyMapping.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-04.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKPropertyMapping.h"


@implementation PKPropertyMapping

@synthesize propertyName = propertyName_;

- (id)initWithPropertyName:(NSString *)propertyName attributePathComponents:(NSArray *)attributePathComponents {
  self = [super initWithAttributePathComponents:attributePathComponents];
  if (self) {
    propertyName_ = [propertyName copy];
  }
  return self;
}

- (id)initWithPropertyName:(NSString *)propertyName attributeName:(NSString *)attributeName {
  NSArray *components = [attributeName componentsSeparatedByString:@"/"];
  return [self initWithPropertyName:propertyName attributePathComponents:components];
}


+ (id)mappingForPropertyName:(NSString *)propertyName attributePathComponents:(NSArray *)attributePathComponents {
  return [[self alloc] initWithPropertyName:propertyName attributePathComponents:attributePathComponents];
}

+ (id)mappingForPropertyName:(NSString *)propertyName attributeName:(NSString *)attributeName {
  return [[self alloc] initWithPropertyName:propertyName attributeName:attributeName];
}

@end
