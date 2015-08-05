//
//  PKItemFieldValueLocationData.h
//  PodioKit
//
//  Created by Lauge Jepsen on 11/12/2014.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <PodioKit-1.x/PodioKit-1.x.h>

@interface PKItemFieldValueLocationData : PKObjectData <NSCopying>

@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSNumber *latitude;
@property (nonatomic, copy) NSNumber *longitude;
@property (nonatomic, readonly, copy) NSString *formatted;
@property (nonatomic, readonly, copy) NSString *city;
@property (nonatomic, readonly, copy) NSString *country;
@property (nonatomic, readonly, copy) NSString *postalCode;
@property (nonatomic, readonly, copy) NSString *streetAddress;
@property (nonatomic, readonly, copy) NSNumber *mapInSync;

@end
