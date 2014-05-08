//
//  NSDate+PKTAdditions.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 08/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (PKTAdditions)

+ (NSDate *)pkt_dateFromUTCDateString:(NSString *)dateString;
+ (NSDate *)pkt_dateFromUTCDateTimeString:(NSString *)dateTimeString;

- (NSString *)pkt_UTCDateString;
- (NSString *)pkt_UTCDateTimeString;

@end
