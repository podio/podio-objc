//
//  PKMeetingPluginDataFactory.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/7/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKMeetingPluginDataFactory.h"
#import "PKMeetingPluginCitrixData.h"

@implementation PKMeetingPluginDataFactory

+ (id)dataFromDictionary:(NSDictionary *)dict pluginType:(PKMeetingPluginType)pluginType {
  id data = nil;
  
  switch (pluginType) {
    case PKMeetingPluginTypeCitrix:
      data = [PKMeetingPluginCitrixData dataFromDictionary:dict];
      break;
    default:
      break;
  }
  
  return data;
}

@end
