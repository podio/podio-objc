//
//  PKTLocation.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@interface PKTLocation : PKTModel

@property (nonatomic, copy) NSString *fullDescription;
@property (nonatomic, copy) NSString *streetName;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;

- (instancetype)initWithFullDescription:(NSString *)fullDescription streetName:(NSString *)streetName city:(NSString *)city country:(NSString *)country latitude:(double)latitude longitude:(double)longitude;

@end
