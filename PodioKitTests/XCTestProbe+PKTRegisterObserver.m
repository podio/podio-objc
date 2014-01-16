//
//  XCTestProbe+PKRegisterObserver.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "XCTestProbe+PKTRegisterObserver.h"
#import "PKTCoverageTestObserver.h"

@implementation XCTestProbe (PKTRegisterObserver)

+ (void)initialize {
	[super initialize];
  
  // HACK: We need to register the coverage observer to make sure it's called at the end of the
  // test suite run, in order to flush the coverage data to .gcda files.
  NSString *observerString = [NSString stringWithFormat:@"XCTestLog,%@", NSStringFromClass([PKTCoverageTestObserver class])];
	[[NSUserDefaults standardUserDefaults] setValue:observerString forKey:XCTestObserverClassKey];
}

@end
