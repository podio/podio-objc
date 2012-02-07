//
//  PKMeetingPluginCitrixData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/7/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKMeetingPluginCitrixData.h"


static NSString * const PKMeetingPluginCitrixDataMeetingId = @"MeetingId";
static NSString * const PKMeetingPluginCitrixDataInfo = @"Info";
static NSString * const PKMeetingPluginCitrixDataURL = @"URL";

@implementation PKMeetingPluginCitrixData

@synthesize meetingId = meetingId_;
@synthesize info = info_;
@synthesize url = url_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    meetingId_ = [aDecoder decodeIntegerForKey:PKMeetingPluginCitrixDataMeetingId];
    info_ = [[aDecoder decodeObjectForKey:PKMeetingPluginCitrixDataInfo] copy];
    url_ = [[aDecoder decodeObjectForKey:PKMeetingPluginCitrixDataURL] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:meetingId_ forKey:PKMeetingPluginCitrixDataMeetingId];
  [aCoder encodeObject:info_ forKey:PKMeetingPluginCitrixDataInfo];
  [aCoder encodeObject:url_ forKey:PKMeetingPluginCitrixDataURL];
}

- (void)dealloc {
  [info_ release];
  [url_ release];
  [super dealloc];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKMeetingPluginCitrixData *data = [self data];
  
  data.meetingId = [[dict pk_objectForKey:@"id"] integerValue];
  data.info = [dict pk_objectForKey:@"info"];
  data.url = [dict pk_objectForKey:@"url"];
  
  return data;
}

@end
