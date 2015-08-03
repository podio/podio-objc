//
//  PKItemFieldValueLocationData.m
//  PodioKit
//
//  Created by Lauge Jepsen on 11/12/2014.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKItemFieldValueLocationData.h"

@interface PKItemFieldValueLocationData ()

@property (nonatomic, readwrite, copy) NSString *formatted;
@property (nonatomic, readwrite, copy) NSString *city;
@property (nonatomic, readwrite, copy) NSString *country;
@property (nonatomic, readwrite, copy) NSString *postalCode;
@property (nonatomic, readwrite, copy) NSString *streetAddress;
@property (nonatomic, readwrite, assign) BOOL mapInSync;

@end

static NSString * const PKItemFieldValueLocationDataValueKey = @"ItemFieldValueLocationDataValue";
static NSString * const PKItemFieldValueLocationDataLatitudeKey = @"ItemFieldValueLocationDataLatitude";
static NSString * const PKItemFieldValueLocationDataLongitudeKey = @"ItemFieldValueLocationDataLongitude";
static NSString * const PKItemFieldValueLocationDataFormattedKey = @"ItemFieldValueLocationDataFormatted";
static NSString * const PKItemFieldValueLocationDataCityKey = @"ItemFieldValueLocationDataCity";
static NSString * const PKItemFieldValueLocationDataCountryKey = @"ItemFieldValueLocationDataCountry";
static NSString * const PKItemFieldValueLocationDataPostalCodeKey = @"ItemFieldValueLocationDataPostalCode";
static NSString * const PKItemFieldValueLocationDataStreetAddressKey = @"ItemFieldValueLocationDataStreetAddress";
static NSString * const PKItemFieldValueLocationDataMapInSyncKey = @"ItemFieldValueLocationDataMapInSync";

@implementation PKItemFieldValueLocationData

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _value = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataValueKey] copy];
    _latitude = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataLatitudeKey] copy];
    _longitude = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataLongitudeKey] copy];
    _formatted = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataFormattedKey] copy];
    _city = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataCityKey] copy];
    _country = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataCountryKey] copy];
    _postalCode = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataPostalCodeKey] copy];
    _streetAddress = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataStreetAddressKey] copy];
    _mapInSync = [aDecoder decodeBoolForKey:PKItemFieldValueLocationDataMapInSyncKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:_value forKey:PKItemFieldValueLocationDataValueKey];
  [aCoder encodeObject:_latitude forKey:PKItemFieldValueLocationDataLatitudeKey];
  [aCoder encodeObject:_longitude forKey:PKItemFieldValueLocationDataLongitudeKey];
  [aCoder encodeObject:_formatted forKey:PKItemFieldValueLocationDataFormattedKey];
  [aCoder encodeObject:_city forKey:PKItemFieldValueLocationDataCityKey];
  [aCoder encodeObject:_country forKey:PKItemFieldValueLocationDataCountryKey];
  [aCoder encodeObject:_postalCode forKey:PKItemFieldValueLocationDataPostalCodeKey];
  [aCoder encodeObject:_streetAddress forKey:PKItemFieldValueLocationDataStreetAddressKey];
  [aCoder encodeBool:_mapInSync forKey:PKItemFieldValueLocationDataMapInSyncKey];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemFieldValueLocationData *data = [self data];
  
  data.value = [dict pk_objectForKey:@"value"];
  data.latitude = [dict pk_objectForKey:@"lat"];
  data.longitude = [dict pk_objectForKey:@"lng"];
  data.formatted = [dict pk_objectForKey:@"formatted"];
  data.city = [dict pk_objectForKey:@"city"];
  data.country = [dict pk_objectForKey:@"country"];
  data.postalCode = [dict pk_objectForKey:@"postal_code"];
  data.streetAddress = [dict pk_objectForKey:@"street_address"];
  data.mapInSync = [dict pk_objectForKey:@"map_in_sync"];
  
  return data;
}

@end
