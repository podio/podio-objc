//
//  POCompoundMapping.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/26/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKCompoundMapping.h"


static NSString * const POInvalidMappingClassException = @"POInvalidMappingClassException";

@implementation PKCompoundMapping

- (id)initWithAttributePathComponents:(NSArray *)attributePathComponents {
  self = [super initWithAttributePathComponents:attributePathComponents];
  if (self) {
    mappings_ = [[NSMutableArray alloc] init];
  }
  return self;
}


- (NSArray *)mappings {
  return mappings_;
}

- (void)addMapping:(id)mapping {
  if (![mapping isKindOfClass:[PKAttributeMapping class]]) {
    @throw [NSException exceptionWithName:POInvalidMappingClassException reason:@"The mapping object must be of class POAttributeMapping." userInfo:nil];
  }
  
  [mappings_ addObject:mapping];
}

@end
