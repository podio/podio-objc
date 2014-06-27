//
//  PKTTaskAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 25/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"
#import "PKTTaskRequestParameters.h"

@interface PKTTaskAPI : PKTBaseAPI

+ (PKTRequest *)requestForTasksWithParameters:(PKTTaskRequestParameters *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit;

@end
