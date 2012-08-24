//
//  PKAsyncTestCase.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/17/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

//  Logic unit tests contain unit test code that is designed to be linked into an independent test executable.
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import "PKTestCase.h"

@interface PKAsyncTestCase : PKTestCase {

 @protected
  BOOL done;
}

- (BOOL)waitForCompletion;
- (BOOL)waitForCompletion:(NSTimeInterval)timeoutSeconds;
- (void)didFinish;
- (void)reset;

@end
