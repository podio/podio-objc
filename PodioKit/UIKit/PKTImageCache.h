//
//  PKTImageCache.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 25/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PKTFile;

@interface PKTImageCache : NSCache

+ (instancetype)sharedCache;

- (void)clearCache;

- (UIImage *)cachedImageForFile:(PKTFile *)file;

- (void)setCachedImage:(UIImage *)image forFile:(PKTFile *)file;

@end
