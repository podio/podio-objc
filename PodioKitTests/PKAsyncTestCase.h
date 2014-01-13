//
//  PKAsyncTestCase.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/17/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface PKAsyncTestCase : XCTestCase {

 @protected
  NSUInteger waitingCount;
}

- (BOOL)waitForCompletion;
- (BOOL)waitForCompletion:(NSTimeInterval)timeoutSeconds;
- (void)didFinish;

- (void)expectNotificiationWithName:(NSString *)name object:(id)object inBlock:(void (^)(void))block;

@end
