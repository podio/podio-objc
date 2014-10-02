//
//  PKTEmbedsAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"

@interface PKTEmbedsAPI : PKTBaseAPI

+ (PKTRequest *)requestToAddEmbedWithURLString:(NSString *)URLString;

@end
