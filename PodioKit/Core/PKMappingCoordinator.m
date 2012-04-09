//
//  PKMappingCoordinator.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/14/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKMappingCoordinator.h"

@implementation PKMappingCoordinator

@synthesize mappingProvider = mappingProvider_;

- (id)initWithMappingProvider:(PKMappingProvider *)mappingProvider {
  self = [super init];
  if (self) {
    mappingProvider_ = mappingProvider;
  }
  return self;
}


// Implement in subclass to provide a properly configured object mapper instance
- (PKObjectMapper *)objectMapper {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

@end
