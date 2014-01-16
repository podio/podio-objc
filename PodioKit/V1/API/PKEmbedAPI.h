//
//  PKEmbedAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/17/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKBaseAPI.h"

@interface PKEmbedAPI : PKBaseAPI

+ (PKRequest *)requestToCreateEmbedWithURLString:(NSString *)urlString;

@end
