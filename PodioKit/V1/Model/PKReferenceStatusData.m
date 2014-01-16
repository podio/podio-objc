//
//  PKReferenceStatusData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKReferenceStatusData.h"


static NSString * const PKReferenceStatusDataStatusId = @"StatusId";
static NSString * const PKReferenceStatusDataValue = @"Value";

@implementation PKReferenceStatusData

@synthesize statusId = statusId_;
@synthesize value = value_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    statusId_ = [aDecoder decodeIntegerForKey:PKReferenceStatusDataStatusId];
    value_ = [[aDecoder decodeObjectForKey:PKReferenceStatusDataValue] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:statusId_ forKey:PKReferenceStatusDataStatusId];
  [aCoder encodeObject:value_ forKey:PKReferenceStatusDataValue];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceStatusData *data = [self data];
  
  data.statusId = [[dict pk_objectForKey:@"status_id"] integerValue];
  data.value = [dict pk_objectForKey:@"value"];
  
  return data;
}

@end
