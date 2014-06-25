//
//  UIImageView+PKTRemoteImage.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 25/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//


#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

#import <objc/runtime.h>
#import "UIImageView+PKTRemoteImage.h"
#import "PKTImageDownloader.h"
#import "PKTMacros.h"

static const char kCurrentImageOperationKey;

@interface UIImageView ()

@property (nonatomic, strong) AFHTTPRequestOperation *pkt_currentImageOperation;

@end

@implementation UIImageView (PKTRemoteImage)

- (AFHTTPRequestOperation *)pkt_currentImageOperation {
  return objc_getAssociatedObject(self, &kCurrentImageOperationKey);
}

- (void)setPkt_currentImageOperation:(AFHTTPRequestOperation *)pkt_currentImageOperation {
  objc_setAssociatedObject(self, &kCurrentImageOperationKey, pkt_currentImageOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Public

- (void)pkt_setImageWithFile:(PKTFile *)file placeholderImage:(UIImage *)placeholderImage completion:(void (^)(UIImage *image, NSError *error))completion {
  [self pkt_cancelCurrentImageOperation];
  
  PKT_WEAK_SELF weakSelf = self;
  [PKTImageDownloader setImageWithFile:file placeholderImage:placeholderImage imageSetterBlock:^(UIImage *image) {
    weakSelf.image = image;
  } completion:^(UIImage *image, NSError *error) {
    weakSelf.pkt_currentImageOperation = nil;
    
    if (completion) completion(image, error);
  }];
}

- (void)pkt_cancelCurrentImageOperation {
  [self.pkt_currentImageOperation cancel];
  self.pkt_currentImageOperation = nil;
}

@end

#endif
