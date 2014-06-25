//
//  PKTImageCacheTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 25/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTImageCache.h"
#import "PKTFile.h"

@interface PKTImageCacheTests : XCTestCase

@end

@implementation PKTImageCacheTests

- (void)testSetAndGetImage {
  PKTFile *file = [[self class] dummyFile];
  UIImage *image = [[self class] dummyImage];
  
  PKTImageCache *cache = [PKTImageCache new];
  expect([cache cachedImageForFile:file]).to.beNil();
  
  [cache setCachedImage:image forFile:file];
  expect([cache cachedImageForFile:file]).to.equal(image);
}

- (void)testClearCache {
  PKTFile *file = [[self class] dummyFile];
  UIImage *image = [[self class] dummyImage];
  
  PKTImageCache *cache = [PKTImageCache new];
  [cache setCachedImage:image forFile:file];
  
  [cache clearCache];
  expect([cache cachedImageForFile:file]).to.beNil();
}

#pragma mark - Helpers

+ (UIImage *)dummyImage {
  static UIImage *image = nil;
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^{
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"Podio" ofType:@"png"];
    image = [UIImage imageWithContentsOfFile:path];
  });
  
  return image;
}

+ (PKTFile *)dummyFile {
  return  [[PKTFile alloc] initWithDictionary:@{
    @"file_id" : @11111,
    @"link" : @"https://files.podio.com/11111"
  }];
}

@end
