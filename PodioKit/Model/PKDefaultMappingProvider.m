//
//  PKDefaultMappingProvider.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/12/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKDefaultMappingProvider.h"

@implementation PKDefaultMappingProvider

- (void)buildClassMap {
  // Tasks
  [self addMappedClassName:@"PKTask" forMappingClassName:@"PKTaskMapping"];
}

@end
