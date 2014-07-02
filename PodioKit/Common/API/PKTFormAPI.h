//
//  PKTFormAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"

@interface PKTFormAPI : PKTBaseAPI

+ (PKTRequest *)requestForFormWithID:(NSUInteger)formID;

@end
