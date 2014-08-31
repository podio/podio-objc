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
#import "PKTAsyncTask.h"

static const char kCurrentImageTaskKey;
static const char kCurrentBackgroundImageTaskKey;

@interface UIButton ()

@property (nonatomic, strong, setter = pkt_setCurrentImageTask:) PKTAsyncTask *pkt_currentImageTask;
@property (nonatomic, strong, setter = pkt_setCurrentBackgroundImageTask:) PKTAsyncTask *pkt_currentBackgroundImageTask;

@end

@implementation UIButton (PKTRemoteImage)

- (PKTAsyncTask *)pkt_currentImageTask {
  return objc_getAssociatedObject(self, &kCurrentImageTaskKey);
}

- (void)pkt_setCurrentImageTask:(PKTAsyncTask *)pkt_currentImageTask {
  objc_setAssociatedObject(self, &kCurrentImageTaskKey, pkt_currentImageTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (PKTAsyncTask *)pkt_currentBackgroundImageTask {
  return objc_getAssociatedObject(self, &kCurrentBackgroundImageTaskKey);
}

- (void)pkt_setCurrentBackgroundImageTask:(PKTAsyncTask *)pkt_currentBackgroundImageTask {
  objc_setAssociatedObject(self, &kCurrentBackgroundImageTaskKey, pkt_currentBackgroundImageTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Public

- (PKTAsyncTask *)pkt_setImageWithFile:(PKTFile *)file forState:(UIControlState)state placeholderImage:(UIImage *)placeholderImage {
  [self pkt_cancelCurrentImageDownload];
  
  PKT_WEAK_SELF weakSelf = self;
  self.pkt_currentImageTask = [[PKTImageDownloader setImageWithFile:file placeholderImage:placeholderImage imageSetterBlock:^(UIImage *image) {
    [weakSelf setImage:image forState:state];
  }] then:^(id result, NSError *error) {
    weakSelf.pkt_currentImageTask = nil;
  }];
  
  return self.pkt_currentImageTask;
}

- (PKTAsyncTask *)pkt_setBackgroundImageWithFile:(PKTFile *)file forState:(UIControlState)state placeholderImage:(UIImage *)placeholderImage {
  [self pkt_cancelCurrentBackgroundImageDownload];
  
  PKT_WEAK_SELF weakSelf = self;
  self.pkt_currentBackgroundImageTask = [[PKTImageDownloader setImageWithFile:file placeholderImage:placeholderImage imageSetterBlock:^(UIImage *image) {
    [weakSelf setBackgroundImage:image forState:state];
  }] then:^(id result, NSError *error) {
    weakSelf.pkt_currentBackgroundImageTask = nil;
  }];
  
  return self.pkt_currentBackgroundImageTask;
}

- (void)pkt_cancelCurrentImageDownload {
  [self.pkt_currentImageTask cancel];
  self.pkt_currentImageTask = nil;
}

- (void)pkt_cancelCurrentBackgroundImageDownload {
  [self.pkt_currentBackgroundImageTask cancel];
  self.pkt_currentBackgroundImageTask = nil;
}


@end

#endif