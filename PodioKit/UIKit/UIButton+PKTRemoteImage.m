//
//  UIButton+PKTRemoteImage.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 25/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

#import <objc/runtime.h>
#import "UIButton+PKTRemoteImage.h"
#import "PKTImageDownloader.h"
#import "PKTMacros.h"

static const char kCurrentImageOperationKey;
static const char kCurrentBackgroundImageOperationKey;

@interface UIButton ()

@property (nonatomic, strong) AFHTTPRequestOperation *pkt_currentImageOperation;
@property (nonatomic, strong) AFHTTPRequestOperation *pkt_currentBackgroundImageOperation;

@end

@implementation UIButton (PKTRemoteImage)

- (AFHTTPRequestOperation *)pkt_currentImageOperation {
  return objc_getAssociatedObject(self, &kCurrentImageOperationKey);
}

- (void)setPkt_currentImageOperation:(AFHTTPRequestOperation *)pkt_currentImageOperation {
  objc_setAssociatedObject(self, &kCurrentImageOperationKey, pkt_currentImageOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AFHTTPRequestOperation *)pkt_currentBackgroundImageOperation {
  return objc_getAssociatedObject(self, &kCurrentBackgroundImageOperationKey);
}

- (void)setPkt_currentBackgroundImageOperation:(AFHTTPRequestOperation *)pkt_currentBackgroundImageOperation {
  objc_setAssociatedObject(self, &kCurrentBackgroundImageOperationKey, pkt_currentBackgroundImageOperation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Public

- (void)pkt_setImageWithFile:(PKTFile *)file forState:(UIControlState)state placeholderImage:(UIImage *)placeholderImage completion:(void (^)(UIImage *image, NSError *error))completion {
  [self pkt_cancelCurrentImageOperation];
  
  PKT_WEAK_SELF weakSelf = self;
  [PKTImageDownloader setImageWithFile:file placeholderImage:placeholderImage imageSetterBlock:^(UIImage *image) {
    [weakSelf setImage:image forState:state];
  } completion:^(UIImage *image, NSError *error) {
    weakSelf.pkt_currentImageOperation = nil;
    
    if (completion) completion(image, error);
  }];
}

- (void)pkt_setBackgroundImageWithFile:(PKTFile *)file forState:(UIControlState)state placeholderImage:(UIImage *)placeholderImage completion:(void (^)(UIImage *image, NSError *error))completion {
  [self pkt_cancelCurrentBackgroundImageOperation];
  
  PKT_WEAK_SELF weakSelf = self;
  [PKTImageDownloader setImageWithFile:file placeholderImage:placeholderImage imageSetterBlock:^(UIImage *image) {
    [weakSelf setBackgroundImage:image forState:state];
  } completion:^(UIImage *image, NSError *error) {
    weakSelf.pkt_currentBackgroundImageOperation = nil;
    
    if (completion) completion(image, error);
  }];
}

- (void)pkt_cancelCurrentImageOperation {
  [self.pkt_currentImageOperation cancel];
  self.pkt_currentImageOperation = nil;
}

- (void)pkt_cancelCurrentBackgroundImageOperation {
  [self.pkt_currentBackgroundImageOperation cancel];
  self.pkt_currentBackgroundImageOperation = nil;
}


@end

#endif