//
//  UIButton+PKTRemoteImage.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 25/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

#import <UIKit/UIKit.h>

@class PKTFile;

@interface UIButton (PKTRemoteImage)

- (void)pkt_setImageWithFile:(PKTFile *)file forState:(UIControlState)state placeholderImage:(UIImage *)placeholderImage completion:(void (^)(UIImage *image, NSError *error))completion;
- (void)pkt_setBackgroundImageWithFile:(PKTFile *)file forState:(UIControlState)state placeholderImage:(UIImage *)placeholderImage completion:(void (^)(UIImage *image, NSError *error))completion;

- (void)pkt_cancelCurrentImageDownload;
- (void)pkt_cancelCurrentBackgroundImageDownload;

@end

#endif