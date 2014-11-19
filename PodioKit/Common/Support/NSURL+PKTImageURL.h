//
//  NSURL+PKTImageURL.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 19/11/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTFile.h"

@interface NSURL (PKTImageURL)

- (NSURL *)pkt_imageURLForSize:(PKTImageSize)size;

@end
