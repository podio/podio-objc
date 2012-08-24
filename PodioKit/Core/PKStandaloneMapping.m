//
//  PKStandaloneMapping.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/26/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKStandaloneMapping.h"
#import "PKObjectMapping.h"

@implementation PKStandaloneMapping

@synthesize objectMapping = objectMapping_;
@synthesize scopePredicateBlock = scopePredicateBlock_;

- (id)initWithAttributeName:(NSString *)attributeName 
              objectMapping:(PKObjectMapping *)objectMapping {
  self = [super initWithAttributeName:attributeName];
  if (self) {
    self.objectMapping = objectMapping;
    scopePredicateBlock_ = nil;
  }
  return self;
}

+ (id)mappingForAttributeName:(NSString *)attributeName 
                objectMapping:(PKObjectMapping *)objectMapping {
  return [[self alloc] initWithAttributeName:attributeName 
                                objectMapping:objectMapping];
}


@end
