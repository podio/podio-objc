//
//  UIImageView+PKTRemoteImage.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 25/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

#import <UIKit/UIKit.h>

@class PKTFile;
@class PKTAsyncTask;

@interface UIImageView (PKTRemoteImage)

- (PKTAsyncTask *)pkt_setImageWithFile:(PKTFile *)file placeholderImage:(UIImage *)placeholderImage;

- (void)pkt_cancelCurrentImageDownload;

@end

#endif
