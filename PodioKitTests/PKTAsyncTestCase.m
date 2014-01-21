//
//  PKTAsyncTestCase.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/17/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKTAsyncTestCase.h"


static NSTimeInterval const kDefaultTimeout = 5.0;

@interface PKTAsyncTestCase ()

@property (nonatomic) NSUInteger count;
@property (nonatomic, copy) NSDate *timeoutDate;

@end

@implementation PKTAsyncTestCase

- (void)waitForCompletionWithBlock:(void (^)(void))block {
  return [self waitForCompletion:kDefaultTimeout block:block];
}


- (void)waitForCompletion:(NSTimeInterval)timeoutSeconds block:(void (^)(void))block {
  self.timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSeconds];
  
  NSUInteger completionCount = self.count;
  self.count++;
  
  block();
  
  // Wait for `finish` to be called
  do {
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:self.timeoutDate];
    if([self.timeoutDate timeIntervalSinceNow] < 0.0)
      break;
  } while (self.count > completionCount);
  
  // Store completed value
  BOOL didComplete = self.count == completionCount;
  [self reset];
  
  XCTAssertTrue(didComplete, @"Asynchronous block did not complete as expected.");
}

- (void)finish {
  self.count--;
}

- (void)reset {
  self.count = 0;
}

- (void)waitForNotificiationWithName:(NSString *)name object:(id)object inBlock:(void (^)(void))block {
  __block BOOL didReceiveNotification = NO;

  id observer = [[NSNotificationCenter defaultCenter] addObserverForName:name
                                                                  object:object
                                                                   queue:[NSOperationQueue mainQueue]
                                                              usingBlock:^(NSNotification *note) {
    didReceiveNotification = YES;
    [self finish];
  }];
  
  [self waitForCompletionWithBlock:^{
    block();
  }];
  
  [[NSNotificationCenter defaultCenter] removeObserver:observer];
  
  XCTAssertTrue(didReceiveNotification, @"Expected notification %@ not received from object %@.", name, object);
}

@end
