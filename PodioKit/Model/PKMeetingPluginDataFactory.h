//
//  PKMeetingPluginDataFactory.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/7/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKMeetingPluginDataFactory : NSObject

+ (id)dataFromDictionary:(NSDictionary *)dict pluginType:(PKMeetingPluginType)pluginType;

@end
