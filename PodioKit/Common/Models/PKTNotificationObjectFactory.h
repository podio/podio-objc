//
//  PKTNotificationObjectFactory.h
//  PodioKit
//
//  Created by Romain Briche on 21/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKTNotificationObjectFactory : NSObject

+ (id)notificationObjectFromDictionary:(NSDictionary *)dictionary;
+ (id)notificationObjectFromData:(NSDictionary *)data type:(NSUInteger)type;

@end
