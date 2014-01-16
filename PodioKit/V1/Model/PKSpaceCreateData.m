//
//  PKSpaceCreateData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/27/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKSpaceCreateData.h"


static NSString * const PKSpaceCreateDataStatus = @"Status";

@implementation PKSpaceCreateData

@synthesize status = status_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    status_ = [aDecoder decodeIntegerForKey:PKSpaceCreateDataStatus];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:status_ forKey:PKSpaceCreateDataStatus];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKSpaceCreateData *data = [self data];
  
  data.status = [PKConstants spaceCreateStatusForString:[dict pk_objectForKey:@"status"]];
  
  return data;
}

@end
