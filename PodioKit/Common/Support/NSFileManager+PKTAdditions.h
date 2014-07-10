//
//  NSFileManager+PKTAdditions.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (PKTAdditions)

- (BOOL)pkt_moveItemAtURL:(NSURL *)fromURL toPath:(NSString *)toPath withIntermediateDirectories:(BOOL)withIntermediateDirectories error:(NSError **)error;

- (BOOL)pkt_moveItemAtPath:(NSString *)fromPath toURL:(NSURL *)toURL withIntermediateDirectories:(BOOL)withIntermediateDirectories error:(NSError **)error;

- (BOOL)pkt_moveItemAtURL:(NSURL *)fromURL toURL:(NSURL *)toURL withIntermediateDirectories:(BOOL)withIntermediateDirectories error:(NSError **)error;

@end
