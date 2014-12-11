//
//  PKItemFieldValueLocationData.h
//  PodioKit
//
//  Created by Lauge Jepsen on 11/12/2014.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <PodioKit-1.x/PodioKit-1.x.h>

@interface PKItemFieldValueLocationData : PKObjectData

@property (nonatomic, copy) NSString *value;
@property (nonatomic) NSNumber *latitude;
@property (nonatomic) NSNumber *longitude;

@end
