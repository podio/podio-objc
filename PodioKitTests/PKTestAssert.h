//
//  PKTestAssert.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/4/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PKAssertNil(a1)              PKAssert(a1 == nil, @"Should be nil")
#define PKAssertNotNil(a1)           PKAssert(a1 != nil, @"Should not be nil")
#define PKAssertGreaterThanZero(a1)  PKAssert(a1 > 0, @"Should be greater than 0")
#define PKAssertZero(a1)             PKAssert(a1 == 0, @"Should be 0")
#define PKAssertEquals(a1, a2)       PKAssert(a1 == a2, @"Should be equal")