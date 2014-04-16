//
//  PKTHTTPStubs.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKTHTTPStubs : NSObject

+ (void)stubResponseForPath:(NSString *)path responseFilename:(NSString *)responseFilename;
+ (void)stubResponseForPath:(NSString *)path responseObject:(id)responseObject;
+ (void)stubResponseForPath:(NSString *)path statusCode:(int)statusCode;
+ (void)stubResponseForPath:(NSString *)path requestTime:(int)requestTime responseTime:(int)responseTime;
+ (void)stubNetworkDownForPath:(NSString *)path;

@end
