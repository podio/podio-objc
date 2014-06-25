//
//  PKTImageCache.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 25/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTImageCache.h"
#import "PKTFile.h"

@implementation PKTImageCache

- (instancetype)init {
  self = [super init];
  if (!self) return nil;
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearCache) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
  
  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
}

#pragma mark - Public

+ (instancetype)sharedCache {
  static id sharedCache;
  static dispatch_once_t once;
  
  dispatch_once(&once, ^{
    sharedCache = [[self alloc] init];
  });
  
  return sharedCache;
}

- (void)clearCache {
  [self removeAllObjects];
}

- (UIImage *)cachedImageForFile:(PKTFile *)file {
  return [self objectForKey:file.link.absoluteString];
}

- (void)setCachedImage:(UIImage *)image forFile:(PKTFile *)file {
  [self setObject:image forKey:file.link.absoluteString];
}

@end
