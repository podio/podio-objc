//
//  PKUserAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/12/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKBaseAPI.h"

@interface PKUserAPI : PKBaseAPI

+ (PKRequest *)requestForUserStatus;

@end
