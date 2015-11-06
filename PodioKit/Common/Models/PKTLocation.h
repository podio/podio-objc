//
//  PKTLocation.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@class PKTAsyncTask;

typedef double PKTLocationCoordinate;

@interface PKTLocation : PKTModel

@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *formattedValue;
@property (nonatomic, copy) NSString *streetName;
@property (nonatomic, copy) NSString *streetNumber;
@property (nonatomic, copy) NSString *postalCode;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, assign) PKTLocationCoordinate latitude;
@property (nonatomic, assign) PKTLocationCoordinate longitude;

@property (nonatomic, copy, readonly) NSString *streetAddress;

- (instancetype)initWithValue:(NSString *)value
               formattedValue:(NSString *)formattedValue
                   streetName:(NSString *)streetName
                 streetNumber:(NSString *)streetNumber
                   postalCode:(NSString *)postalCode
                         city:(NSString *)city
                        state:(NSString *)state
                      country:(NSString *)country
                     latitude:(PKTLocationCoordinate)latitude
                    longitude:(PKTLocationCoordinate)longitude NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithValue:(NSString *)value;

- (instancetype)initWithLatitude:(PKTLocationCoordinate)latitude longitude:(PKTLocationCoordinate)longitude;

+ (PKTAsyncTask *)lookupAddress:(NSString *)addressString;

@end
