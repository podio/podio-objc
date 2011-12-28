//
//  PKLogging.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-06-23.
//  Copyright 2011 Podio. All rights reserved.
//

// Turn overall logging on/off
#define LOG_ENABLED 1

// Log levels
#ifdef DEBUG
#define LOG_LEVEL_DEBUG 1
#else
#define LOG_LEVEL_DEBUG 0
#endif

#define LOG_LEVEL_INFO 1
#define LOG_LEVEL_WARNING 1
#define LOG_LEVEL_ERROR 1

// Print class/selector/line?
#define LOG_INCLUDE_CODE_LOCATION 0

// Print macros
#if LOG_ENABLED
#if LOG_INCLUDE_CODE_LOCATION
// Include line info
#define CODE_LOCATION [NSString stringWithFormat:@"[%@ %@] ~%d:", NSStringFromClass([self class]), NSStringFromSelector(_cmd), __LINE__]
#define POLog(fmt, ...) NSLog(@"%@ " fmt, CODE_LOCATION, ##__VA_ARGS__)
#else
// No line info
#define POLog(fmt, ...) NSLog(fmt, ##__VA_ARGS__)
#endif
#else
// No logging
#define POLog(...)
#endif

#if LOG_ENABLED && LOG_LEVEL_DEBUG
#define POLogDebug(fmt, ...) POLog(@"DEBUG: " fmt, ##__VA_ARGS__)
#else
#define POLogDebug(fmt, ...)
#endif

#if LOG_ENABLED && LOG_LEVEL_INFO
#define POLogInfo(fmt, ...) POLog(@"INFO: " fmt, ##__VA_ARGS__)
#else
#define POLogInfo(fmt, ...)
#endif

#if LOG_ENABLED && LOG_LEVEL_WARNING
#define POLogWarn(fmt, ...) POLog(@"WARNING: " fmt, ##__VA_ARGS__)
#else
#define POLogWarn(fmt, ...)
#endif

#if LOG_ENABLED && LOG_LEVEL_ERROR
#define POLogError(fmt, ...) POLog(@"ERROR: " fmt, ##__VA_ARGS__)
#else
#define POLogError(fmt, ...)
#endif

// Custom type logging
#define POLogCGRect(rect) POLogDebug(@"CGRect: %.1f, y=%.1f, w=%.1f, h=%.1f", CGRectGetMinX(rect), CGRectGetMinY(rect), CGRectGetWidth(rect), CGRectGetHeight(rect))
#define POLogCGSize(size) POLogDebug(@"CGSize: w=%.1f, h=%.1f", size.width, size.height)