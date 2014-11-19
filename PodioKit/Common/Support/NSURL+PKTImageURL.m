//
//  NSURL+PKTImageURL.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 19/11/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSURL+PKTImageURL.h"

@implementation NSURL (PKTImageURL)

- (NSURL *)pkt_imageURLForSize:(PKTImageSize)size {
  NSURL *url = [self copy];
  
  NSString *sizeString = nil;
  switch (size) {
    case PKTImageSizeDefault:
      sizeString = @"default";
      break;
    case PKTImageSizeTiny:
      sizeString = @"tiny";
      break;
    case PKTImageSizeSmall:
      sizeString = @"small";
      break;
    case PKTImageSizeMedium:
      sizeString = @"medium";
      break;
    case PKTImageSizeLarge:
      sizeString = @"large";
      break;
    case PKTImageSizeExtraLarge:
      sizeString = @"extra_large";
      break;
    default:
      break;
  }
  
  if (sizeString) {
    // Append x2 since most iOS devices are retina
    sizeString = [sizeString stringByAppendingString:@"_x2"];
    url = [url URLByAppendingPathComponent:sizeString];
  }
  
  return url;
}

@end
