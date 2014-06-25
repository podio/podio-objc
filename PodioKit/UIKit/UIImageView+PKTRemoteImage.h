//
//  UIImageView+PKTRemoteImage.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 25/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

#import <UIKit/UIKit.h>
#import "PKTFile.h"

@interface UIImageView (PKTRemoteImage)

- (void)pkt_setImageWithFile:(PKTFile *)file placeholderImage:(UIImage *)placeholderImage completion:(void (^)(UIImage *image, NSError *error))completion;

- (void)pkt_cancelCurrentImageOperation;

@end

#endif
