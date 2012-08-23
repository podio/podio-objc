//
//  PKAsyncTestCase.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/17/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKAsyncTestCase.h"


static NSTimeInterval const kDefaultTimeout = 60.0;

@implementation PKAsyncTestCase

- (BOOL)waitForCompletion {
  return [self waitForCompletion:kDefaultTimeout];
}

- (BOOL)waitForCompletion:(NSTimeInterval)timeoutSeconds {
  NSDate *timeoutDate = [NSDate dateWithTimeIntervalSinceNow:timeoutSeconds];
  
  do {
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:timeoutDate];
    if([timeoutDate timeIntervalSinceNow] < 0.0)
      break;
  } while (!done);
  
  // Store completed value
  BOOL result = done;
  [self reset];
  
  return result;
}

- (void)didFinish {
  done = YES;
}

- (void)reset {
  done = NO;
}

@end
