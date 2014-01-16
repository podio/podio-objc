//
//  PKExternalMeetingData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/7/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKExternalMeetingData.h"


static NSString * const PKExternalMeetingDataType = @"Type";
static NSString * const PKExternalMeetingDataExternalId = @"ExternalId";
static NSString * const PKExternalMeetingDataInfo = @"Info";
static NSString * const PKExternalMeetingDataURL = @"URL";

@implementation PKExternalMeetingData

@synthesize type = type_;
@synthesize externalId = externalId_;
@synthesize info = info_;
@synthesize url = url_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    type_ = [aDecoder decodeIntegerForKey:PKExternalMeetingDataType];
    externalId_ = [[aDecoder decodeObjectForKey:PKExternalMeetingDataExternalId] copy];
    info_ = [[aDecoder decodeObjectForKey:PKExternalMeetingDataInfo] copy];
    url_ = [[aDecoder decodeObjectForKey:PKExternalMeetingDataURL] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:type_ forKey:PKExternalMeetingDataType];
  [aCoder encodeObject:externalId_ forKey:PKExternalMeetingDataExternalId];
  [aCoder encodeObject:info_ forKey:PKExternalMeetingDataInfo];
  [aCoder encodeObject:url_ forKey:PKExternalMeetingDataURL];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKExternalMeetingData *data = [self data];
  
  data.type = [PKConstants externalMeetingTypeForString:[dict pk_objectForKey:@"type"]];
  data.externalId = [dict pk_objectForKey:@"id"];
  data.info = [dict pk_objectForKey:@"info"];
  data.url = [dict pk_objectForKey:@"url"];
  
  return data;
}

@end
