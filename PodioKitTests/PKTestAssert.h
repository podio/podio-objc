//
//  PKTestAssert.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/4/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>

#define PKAssertNil(a1)              STAssertTrue(a1 == nil, @"Should be nil")
#define PKAssertNotNil(a1)           STAssertTrue(a1 != nil, @"Should not be nil")
#define PKAssertGreaterThanZero(a1)  STAssertTrue(a1 > 0, @"Should be greater than 0")
#define PKAssertZero(a1)             STAssertTrue(a1 == 0, @"Should be 0")
#define PKAssertEquals(a1, a2)       STAssertTrue(a1 == a2, @"Should be equal")