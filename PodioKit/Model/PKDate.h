//
//  PKDate.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 21/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKDate : NSObject <NSCopying, NSCoding>

@property (nonatomic, copy, readonly) NSDate *date;
@property (nonatomic, assign, readonly) BOOL includesTimeComponent;

+ (instancetype)dateWithDate:(NSDate *)date includesTimeComponent:(BOOL)includesTimeComponent;

@end
