//
//  PKTRequestTaskHandle.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 08/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTRequestTaskHandle.h"
#import "PKTRequestTaskDescriptor.h"

@interface PKTRequestTaskHandle ()

@property (nonatomic, strong) PKTRequestTaskDescriptor *descriptor;

@end

@implementation PKTRequestTaskHandle

- (instancetype)initWithDescriptor:(PKTRequestTaskDescriptor *)descriptor {
  self = [super init];
  if (!self) return nil;
  
  _descriptor = descriptor;
  
  return self;
}

#pragma mark - Public

- (PKTRequest *)request {
  return self.descriptor.request;
}

+ (instancetype)handleForDescriptor:(PKTRequestTaskDescriptor *)descriptor {
  return [[self alloc] initWithDescriptor:descriptor];
}

- (void)cancel {
  [self.descriptor cancel];
}

@end
