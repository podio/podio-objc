//
//  PKReferenceMeetingData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/2/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKReferenceMeetingData.h"
#import "PKMeetingPluginDataFactory.h"


static NSString * const PKReferenceMeetingDataMeetingId = @"MeetingId";
static NSString * const PKReferenceMeetingDataPluginType = @"PluginType";
static NSString * const PKReferenceMeetingDataPluginData = @"PluginData";

@implementation PKReferenceMeetingData

@synthesize meetingId = meetingId_;
@synthesize pluginType = pluginType_;
@synthesize pluginData = pluginData_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    meetingId_ = [aDecoder decodeIntegerForKey:PKReferenceMeetingDataMeetingId];
    pluginType_ = [aDecoder decodeIntegerForKey:PKReferenceMeetingDataPluginType];
    pluginData_ = [aDecoder decodeObjectForKey:PKReferenceMeetingDataPluginData];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:meetingId_ forKey:PKReferenceMeetingDataMeetingId];
  [aCoder encodeInteger:pluginType_ forKey:PKReferenceMeetingDataPluginType];
  [aCoder encodeObject:pluginData_ forKey:PKReferenceMeetingDataPluginData];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceMeetingData *data = [self data];
  
  data.meetingId = [[dict pk_objectForKey:@"meeting_id"] integerValue];
  data.pluginType = [PKConstants meetingPluginTypeForString:[dict pk_objectForKey:@"plugin"]];
  
  if (data.pluginType != PKMeetingPluginTypeNone) {
    data.pluginData = [PKMeetingPluginDataFactory dataFromDictionary:[dict pk_objectForKey:@"plugin_data"] pluginType:data.pluginType];
  }
  
  return data;
}

@end
