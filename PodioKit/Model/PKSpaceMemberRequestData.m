//
//  PKSpaceMemberRequestData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/29/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKSpaceMemberRequestData.h"


static NSString * const PKSpaceMemberRequestDataRequestId = @"RequestId";
static NSString * const PKSpaceMemberRequestDataSpaceId = @"SpaceId";
static NSString * const PKSpaceMemberRequestDataStatus = @"Status";

@implementation PKSpaceMemberRequestData

@synthesize requestId = requestId_;
@synthesize spaceId = spaceId_;
@synthesize status = status_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    requestId_ = [aDecoder decodeIntegerForKey:PKSpaceMemberRequestDataRequestId];
    spaceId_ = [aDecoder decodeIntegerForKey:PKSpaceMemberRequestDataSpaceId];
    status_ = [aDecoder decodeIntegerForKey:PKSpaceMemberRequestDataStatus];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:requestId_ forKey:PKSpaceMemberRequestDataRequestId];
  [aCoder encodeInteger:spaceId_ forKey:PKSpaceMemberRequestDataSpaceId];
  [aCoder encodeInteger:status_ forKey:PKSpaceMemberRequestDataStatus];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKSpaceMemberRequestData *data = [self data];
  
  data.requestId = [[dict pk_objectForKey:@"space_member_request_id"] integerValue];
  data.spaceId = [[[dict pk_objectForKey:@"space"] pk_objectForKey:@"space_id"] integerValue];
  data.status = [PKConstants spaceMemberRequestStatusForString:[dict pk_objectForKey:@"status"]];
  
  return data;
}

@end
