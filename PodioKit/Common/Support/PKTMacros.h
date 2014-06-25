//
//  PKTMacros.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 15/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

// References
#define PKT_STRONG(obj) __typeof__(obj)
#define PKT_WEAK(obj) __typeof__(obj) __weak
#define PKT_WEAK_SELF PKT_WEAK(self)

