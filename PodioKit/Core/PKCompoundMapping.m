//
//  PKCompoundMapping.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/26/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKCompoundMapping.h"


static NSString * const PKInvalidMappingClassException = @"PKInvalidMappingClassException";

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
    @throw [NSException exceptionWithName:PKInvalidMappingClassException reason:@"The mapping object must be of class PKAttributeMapping." userInfo:nil];
  }
  
  [mappings_ addObject:mapping];
}

@end
