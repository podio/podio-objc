//
//  PKTCoverageTestObserver.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTCoverageTestObserver.h"

extern void __gcov_flush(void);

@implementation PKTCoverageTestObserver

- (void)stopObserving {
  [super stopObserving];
  
  // Flush coverage data to .gcda files
  __gcov_flush();
}

@end
