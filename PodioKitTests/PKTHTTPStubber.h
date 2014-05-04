//
//  PKTHTTPStubber.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 18/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKTHTTPStubber : NSObject

@property (nonatomic, copy, readonly) NSString *path;
@property (nonatomic, assign) int statusCode;
@property (nonatomic, strong) id responseObject;
@property (nonatomic, copy) NSError *error;
@property (nonatomic, assign) NSTimeInterval requestTime;
@property (nonatomic, assign) NSTimeInterval responseTime;

+ (instancetype)stubberForPath:(NSString *)path;

- (void)stub;

@end
