//
//  PKAssert.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/24/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#ifndef PodioKit_PKAssert_h
#define PodioKit_PKAssert_h

#define PKAssertNil(a1)              STAssertNil(a1, @"Should be nil")
#define PKAssertNotNil(a1)           STAssertNotNil(a1, @"Should not be nil")
#define PKAssertGreaterThanZero(a1)  STAssertTrue(a1 > 0, @"Should be greater than 0")
#define PKAssertZero(a1)             STAssertTrue(a1 == 0, @"Should be 0")
#define PKAssertEquals(a1, a2)       STAssertTrue(a1 == a2, @"Should be equal")

#endif
