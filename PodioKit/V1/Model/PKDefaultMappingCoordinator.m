//
//  PKDefaultMappingCoordinator.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 4/4/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKDefaultMappingCoordinator.h"
#import "PKDefaultObjectRepository.h"

@implementation PKDefaultMappingCoordinator

- (PKObjectMapper *)objectMapper {
  PKDefaultObjectRepository *repository = [[PKDefaultObjectRepository alloc] init];
  PKObjectMapper *mapper = [[PKObjectMapper alloc] initWithProvider:self.mappingProvider repository:repository];
  
  return mapper;
}

@end
