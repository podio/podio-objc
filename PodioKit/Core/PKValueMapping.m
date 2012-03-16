//
//  PKValueMapping.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-04.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKValueMapping.h"


@implementation PKValueMapping

@synthesize valueType = valueType_;
@synthesize block = block_;

- (id)initWithPropertyName:(NSString *)propertyName attributeName:(NSString *)attributeName {
  self = [super initWithPropertyName:propertyName attributeName:attributeName];
  if (self) {
    valueType_ = PKValueTypeNormal;
    block_ = nil;
  }
  return self;
}

- (id)initWithPropertyName:(NSString *)propertyName attributeName:(NSString *)attributeName block:(PKValueMappingBlock)block {
  self = [super initWithPropertyName:propertyName attributeName:attributeName];
  if (self) {
    block_ = [block copy];
  }
  return self;
}


- (id)evaluateForValue:(id)attributeValue objectDict:(NSDictionary *)objectDict parent:(id)parent {
  id value = nil;
  if (block_ == nil) {
    value = attributeValue;
  } else {
    value = block_(attributeValue, objectDict, parent);
  }
  
  return value;
}

@end
