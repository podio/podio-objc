//
//  PKTImageDownloader.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 25/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PKTFile;
@class PKTAsyncTask;

@interface PKTImageDownloader : NSObject

+ (PKTAsyncTask *)setImageWithFile:(PKTFile *)file placeholderImage:(UIImage *)placeholderImage imageSetterBlock:(void (^)(UIImage *image))imageSetterBlock;

@end
