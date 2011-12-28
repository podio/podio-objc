//
//  NSString+POMimeType.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-14.
//  Copyright 2011 Podio. All rights reserved.
//

#import "NSString+PKMimeType.h"


@implementation NSString (PKMimeType)

- (BOOL)pk_isImageMimeType {
	return [self isEqualToString:@"image/bmp"] || 
  [self isEqualToString:@"image/gif"] || 
  [self isEqualToString:@"image/jpeg"] || 
  [self isEqualToString:@"image/png"] || 
  [self isEqualToString:@"image/tiff"];
}

@end
