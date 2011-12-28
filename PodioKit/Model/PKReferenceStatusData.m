//
//  POStreamActivityStatusData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKReferenceStatusData.h"


static NSString * const POStreamActivityStatusDataStatusId = @"StatusId";
static NSString * const POStreamActivityStatusDataValue = @"Value";

@implementation PKReferenceStatusData

@synthesize statusId = statusId_;
@synthesize value = value_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    statusId_ = [aDecoder decodeIntegerForKey:POStreamActivityStatusDataStatusId];
    value_ = [[aDecoder decodeObjectForKey:POStreamActivityStatusDataValue] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:statusId_ forKey:POStreamActivityStatusDataStatusId];
  [aCoder encodeObject:value_ forKey:POStreamActivityStatusDataValue];
}

- (void)dealloc {
  [value_ release];
  [super dealloc];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceStatusData *data = [self data];
  
  data.statusId = [[dict pk_objectForKey:@"status_id"] integerValue];
  data.value = [dict pk_objectForKey:@"value"];
  
  return data;
}

@end
