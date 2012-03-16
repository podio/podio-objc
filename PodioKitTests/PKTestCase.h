//
//  PKTestCase.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/27/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

//  Logic unit tests contain unit test code that is designed to be linked into an independent test executable.
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <SenTestingKit/SenTestingKit.h>

// Macro for skipping tests
#define PK_SKIP_TEST(msg) \
  if (msg != nil) { \
  PKLogInfo(@"Test case [%@ %@:%d] skipped: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), __LINE__, msg); \
  } else { \
  PKLogInfo(@"Test case [%@ %@:%d] skipped", NSStringFromClass([self class]), NSStringFromSelector(_cmd), __LINE__); \
  } \
  return

@interface PKTestCase : SenTestCase

@end
