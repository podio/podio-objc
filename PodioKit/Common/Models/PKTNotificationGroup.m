//
//  PKTNotificationGroup.m
//  PodioKit
//
//  Created by Romain Briche on 19/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKTNotificationGroup.h"
#import "PKTNotificationContext.h"
#import "PKTNotification.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTNotificationGroup

+ (NSValueTransformer *)contextValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTNotificationContext class]];
}

+ (NSValueTransformer *)notificationsValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTNotification class]];
}

@end
