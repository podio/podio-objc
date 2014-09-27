//
//  PKTLocation.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTLocation.h"

@implementation PKTLocation

- (instancetype)initWithValue:(NSString *)value formattedValue:(NSString *)formattedValue streetName:(NSString *)streetName postalCode:(NSString *)postalCode city:(NSString *)city country:(NSString *)country latitude:(double)latitude longitude:(double)longitude {
  self = [super init];
  if (!self) return nil;
  
  _value = [value copy];
  _formattedValue = [formattedValue copy];
  _streetName = [streetName copy];
  _postalCode = [postalCode copy];
  _city = [city copy];
  _country = [country copy];
  _latitude = latitude;
  _longitude = longitude;
  
  return self;
}

#pragma mark - PKModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"value" : @"value",
           @"formattedValue" : @"formatted",
           @"streetName" : @"street_name",
           @"postalCode" : @"postal_code",
           @"latitude" : @"lat",
           @"longitude" : @"lng",
           };
}

@end
