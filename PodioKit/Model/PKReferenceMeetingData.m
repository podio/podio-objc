//
//  PKReferenceMeetingData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/2/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKReferenceMeetingData.h"


static NSString * const PKReferenceMeetingDataMeetingId = @"MeetingId";
static NSString * const PKReferenceMeetingDataExternalId = @"ExternalId";

@implementation PKReferenceMeetingData

@synthesize meetingId = meetingId_;
@synthesize externalId = externalId_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    meetingId_ = [aDecoder decodeIntegerForKey:PKReferenceMeetingDataMeetingId];
    externalId_ = [aDecoder decodeIntegerForKey:PKReferenceMeetingDataExternalId];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:meetingId_ forKey:PKReferenceMeetingDataMeetingId];
  [aCoder encodeInteger:externalId_ forKey:PKReferenceMeetingDataExternalId];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceMeetingData *data = [self data];
  
  data.meetingId = [[dict pk_objectForKey:@"meeting_id"] integerValue];
  data.externalId = [[dict pk_objectForKey:@"external_id"] integerValue];
  
  return data;
}

@end
