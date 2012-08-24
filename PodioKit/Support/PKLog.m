//
//  PKLog.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/5/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKLog.h"

void PKLogWithLine(const char *filePath, int lineNumber, NSString *fmt, ...) {
  va_list args;
  va_start(args, fmt);
  
  NSString *string = [[NSString alloc] initWithFormat:fmt arguments:args];
  NSString *fileName = [@(filePath) lastPathComponent];
  printf("%s:%d %s\n", [fileName UTF8String], lineNumber, [string UTF8String]);
  va_end(args);
}
