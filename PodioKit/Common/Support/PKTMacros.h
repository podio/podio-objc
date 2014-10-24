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

#ifdef __IPHONE_OS_VERSION_MIN_REQUIRED
#define PKT_IOS_SDK_AVAILABLE 1
#else
#define PKT_IOS_SDK_AVAILABLE 0
#endif