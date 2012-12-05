//
//  PKAsyncTestCase.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/17/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKAsyncTestCase.h"


static NSTimeInterval const kDefaultTimeout = 10.0;

@interface PKAsyncTestCase ()

@property (nonatomic, copy) NSDate *timeoutDate;

@end

@implementation PKAsyncTestCase

- (BOOL)waitForCompletion {
  return [self waitForCompletion:kDefaultTimeout];
}

- (BOOL)waitForCompletion:(NSTimeInterval)timeoutSeconds {
  self.timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSeconds];
  
  waitingCount++;
  
  do {
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:self.timeoutDate];
    if([self.timeoutDate timeIntervalSinceNow] < 0.0)
      break;
  } while (waitingCount > 0);
  
  // Store completed value
  BOOL result = waitingCount == 0;
  [self reset];
  
  STAssertTrue(result, @"Timed out.");
  
  return result;
}

- (void)didFinish {
  waitingCount--;
}

- (void)reset {
  waitingCount = 0;
}

- (void)expectNotificiationWithName:(NSString *)name object:(id)object inBlock:(void (^)(void))block {
  __block BOOL didReceiveNotification = NO;
  id observer = [[NSNotificationCenter defaultCenter] addObserverForName:name
                                                                  object:object
                                                                   queue:[NSOperationQueue mainQueue]
                                                              usingBlock:^(NSNotification *note) {
    didReceiveNotification = YES;
    [self didFinish];
  }];
  
  block();
  
  [self waitForCompletion];
  
  [[NSNotificationCenter defaultCenter] removeObserver:observer];
  
  STAssertTrue(didReceiveNotification, @"Expected notification %@ not received from object %@.", name, object);
}

@end
