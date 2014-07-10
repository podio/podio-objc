//
//  NSFileManager+PKTAdditions.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSFileManager+PKTAdditions.h"

@implementation NSFileManager (PKTAdditions)

- (BOOL)pkt_moveItemAtURL:(NSURL *)fromURL toPath:(NSString *)toPath withIntermediateDirectories:(BOOL)withIntermediateDirectories error:(NSError **)error {
  NSURL *toURL = [NSURL fileURLWithPath:toPath];
  
  return [self pkt_moveItemAtURL:fromURL toURL:toURL withIntermediateDirectories:withIntermediateDirectories error:error];
}

- (BOOL)pkt_moveItemAtPath:(NSString *)fromPath toURL:(NSURL *)toURL withIntermediateDirectories:(BOOL)withIntermediateDirectories error:(NSError **)error {
  NSURL *fromURL = [NSURL fileURLWithPath:fromPath];
  
  return [self pkt_moveItemAtURL:fromURL toURL:toURL withIntermediateDirectories:withIntermediateDirectories error:error];
}

- (BOOL)pkt_moveItemAtURL:(NSURL *)fromURL toURL:(NSURL *)toURL withIntermediateDirectories:(BOOL)withIntermediateDirectories error:(NSError **)error {
  BOOL success = YES;
  
  NSString *directoryPath = [toURL.path stringByDeletingLastPathComponent];
  NSURL *directoryURL = [NSURL fileURLWithPath:directoryPath];
  
  success = [self createDirectoryAtURL:directoryURL withIntermediateDirectories:withIntermediateDirectories attributes:nil error:error];
  if (success) {
    if ([self fileExistsAtPath:toURL.path]) {
      [self removeItemAtURL:toURL error:nil];
    }
    
    success = [self moveItemAtURL:fromURL toURL:toURL error:error];
  }
  
  return success;
}

@end
