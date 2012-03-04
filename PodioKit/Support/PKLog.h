//
//  PKLog.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/5/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>

void PKLogWithLine(const char *filePath, int lineNumber, NSString *fmt, ...);

#define PKLog(fmt...) PKLogWithLine(__FILE__, __LINE__, fmt)

// Log levels
#ifdef DEBUG
#define PK_LOG_LEVEL_DEBUG
#endif

#define PK_LOG_LEVEL_INFO
#define PK_LOG_LEVEL_WARNING
#define PK_LOG_LEVEL_ERROR

#ifdef PK_LOG_LEVEL_DEBUG
#define PKLogDebug(fmt...) PKLog(@"DEBUG: " fmt)
#else
#define PKLogDebug(fmt...)
#endif

#ifdef PK_LOG_LEVEL_INFO
#define PKLogInfo(fmt...) PKLog(@"INFO: " fmt)
#else
#define PKLogInfo(fmt...)
#endif

#ifdef PK_LOG_LEVEL_WARNING
#define PKLogWarn(fmt...) PKLog(@"WARNING: " fmt)
#else
#define PKLogWarn(fmt...)
#endif

#ifdef PK_LOG_LEVEL_ERROR
#define PKLogError(fmt...) PKLog(@"ERROR: " fmt)
#else
#define PKLogError(fmt...)
#endif

#define PKLogRect(rect) PKLog(NSStringFromCGRect(rect))
#define PKLogSize(size) PKLog(NSStringFromCGSize(size))