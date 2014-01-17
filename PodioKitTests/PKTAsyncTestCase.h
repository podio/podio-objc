//
//  PKTAsyncTestCase.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/17/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface PKTAsyncTestCase : XCTestCase

- (void)waitForCompletionWithBlock:(void (^)(void))block;
- (void)waitForCompletion:(NSTimeInterval)timeoutSeconds block:(void (^)(void))block;

- (void)finish;

- (void)waitForNotificiationWithName:(NSString *)name object:(id)object inBlock:(void (^)(void))block;

@end
