//
//  PKTFile+UIImage.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 25/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

#import <UIKit/UIKit.h>
#import "PKTFile.h"

@interface PKTFile (UIImage)

/**
 *  Download the file as an UIImage.
 *
 *  @return A task
 */
- (PKTAsyncTask *)downloadImage;

@end

#endif