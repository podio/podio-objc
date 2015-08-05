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
@property (nonatomic, readwrite, copy) NSNumber *mapInSync;

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
    _mapInSync = [aDecoder decodeObjectForKey:PKItemFieldValueLocationDataMapInSyncKey];
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
  [aCoder encodeObject:_mapInSync forKey:PKItemFieldValueLocationDataMapInSyncKey];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemFieldValueLocationData *data = [self data];
  
  data->_value = [[dict pk_objectForKey:@"value"] copy];
  data->_latitude = [[dict pk_objectForKey:@"lat"] copy];
  data->_longitude = [[dict pk_objectForKey:@"lng"] copy];
  data->_formatted = [[dict pk_objectForKey:@"formatted"] copy];
  data->_city = [[dict pk_objectForKey:@"city"] copy];
  data->_country = [[dict pk_objectForKey:@"country"] copy];
  data->_postalCode = [[dict pk_objectForKey:@"postal_code"] copy];
  data->_streetAddress = [[dict pk_objectForKey:@"street_address"] copy];
  data->_mapInSync = [[dict pk_objectForKey:@"map_in_sync"] copy];
  
  return data;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  PKItemFieldValueLocationData *location = [[[self class] allocWithZone:zone] init];
  
  location->_value = [_value copyWithZone:zone];
  location->_latitude = [_latitude copyWithZone:zone];
  location->_longitude = [_longitude copy];
  location->_formatted = [_formatted copy];
  location->_city = [_city copy];
  location->_country = [_country copy];
  location->_postalCode = [_postalCode copy];
  location->_streetAddress = [_streetAddress copy];
  location->_mapInSync = [_mapInSync copy];
  
  return location;
}

@end
