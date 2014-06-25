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
#import "PKTFile+UIImage.h"
#import "PKTMacros.h"

@interface PKTImageCache : NSCache
@end

@implementation PKTImageCache

+ (instancetype)sharedCache {
  static id sharedCache;
  static dispatch_once_t once;
  
  dispatch_once(&once, ^{
    sharedCache = [[self alloc] init];
  });
  
  return sharedCache;
}

- (instancetype)init {
  self = [super init];
  if (!self) return nil;
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearCache) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
  
  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
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


static const char kCurrentImageOperationKey;

@interface UIImageView ()

@property (nonatomic, strong) AFHTTPRequestOperation *pkt_currentImageOperation;

@end

@implementation UIImageView (PKTRemoteImage)

- (AFHTTPRequestOperation *)pkt_currentImageOperation {
  return objc_getAssociatedObject(self, &kCurrentImageOperationKey);
}

- (void)setPkt_currentImageOperation:(AFHTTPRequestOperation *)pkt_currentImageOperation {
  objc_setAssociatedObject(self, &kCurrentImageOperationKey, pkt_currentImageOperation, OBJC_ASSOCIATION_ASSIGN);
}

- (void)pkt_setImageWithFile:(PKTFile *)file placeholderImage:(UIImage *)placeholderImage completion:(void (^)(UIImage *image, NSError *error))completion {
  [self pkt_cancelCurrentImageOperation];
  
  // Check for a cached image
  UIImage *image = [[PKTImageCache sharedCache] cachedImageForFile:file];
  if (image) {
    self.image = image;
    return;
  }
  
  if (placeholderImage) {
    self.image = placeholderImage;
  }
  
  PKT_WEAK_SELF weakSelf = self;
  self.pkt_currentImageOperation = [file downloadImageWithCompletion:^(UIImage *image, NSError *error) {
    PKT_STRONG(weakSelf) strongSelf = weakSelf;
    
    if (image) {
      [[PKTImageCache sharedCache] setCachedImage:image forFile:file];
      strongSelf.image = image;
    }
    
    strongSelf.pkt_currentImageOperation = nil;
    
    if (completion) completion(image, error);
  }];
}

- (void)pkt_cancelCurrentImageOperation {
  [self.pkt_currentImageOperation cancel];
}

@end

#endif
