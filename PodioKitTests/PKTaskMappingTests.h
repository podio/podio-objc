//
//  PKTaskMappingTest.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/12/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

//  Logic unit tests contain unit test code that is designed to be linked into an independent test executable.
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <SenTestingKit/SenTestingKit.h>
#import "PKObjectMapper.h"


@interface PKTaskMappingTests : SenTestCase <PKObjectMapperDelegate>

- (void)testGetActiveTasks;

- (void)testGetTask;

@end
