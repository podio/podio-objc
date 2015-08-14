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
@property (nonatomic, readwrite, copy) NSString *state;
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
static NSString * const PKItemFieldValueLocationDataStateKey = @"ItemFieldValueLocationDataState";
static NSString * const PKItemFieldValueLocationDataMapInSyncKey = @"ItemFieldValueLocationDataMapInSync";

static void * kLocationValueChanged = &kLocationValueChanged;
static void * kStructuredValueChanged = &kStructuredValueChanged;

@implementation PKItemFieldValueLocationData

- (instancetype)init {
  self = [super init];
  if (!self) return nil;
  
  [self startObservingLocationValue];
  [self startObservingStructuredValues];
  
  return self;
}

- (void)dealloc {
  [self stopObservingLocationValue];
  [self stopObservingStructuredValues];
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (!self) return nil;
  
  _value = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataValueKey] copy];
  _latitude = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataLatitudeKey] copy];
  _longitude = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataLongitudeKey] copy];
  _formatted = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataFormattedKey] copy];
  _city = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataCityKey] copy];
  _country = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataCountryKey] copy];
  _postalCode = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataPostalCodeKey] copy];
  _streetAddress = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataStreetAddressKey] copy];
  _state = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataStateKey] copy];
  _mapInSync = [aDecoder decodeObjectForKey:PKItemFieldValueLocationDataMapInSyncKey];
  
  [self startObservingLocationValue];
  [self startObservingStructuredValues];
  
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
  [aCoder encodeObject:_state forKey:PKItemFieldValueLocationDataStateKey];
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
  data->_state = [[dict pk_objectForKey:@"state"] copy];
  data->_mapInSync = [[dict pk_objectForKey:@"map_in_sync"] copy];
  data->_streetAddress = [[self streetAddressFromDictionary:dict] copy];
  
  return data;
}

+ (NSString *)streetAddressFromDictionary:(NSDictionary *)dict {
  NSString *streetAddress = [dict pk_objectForKey:@"street_address"];
  NSString *streetNumber = [dict pk_objectForKey:@"street_number"];
  NSString *streetName = [dict pk_objectForKey:@"street_name"];
  NSString *streetValue = [dict pk_objectForKey:@"formatted"] ?: [dict pk_objectForKey:@"value"];
  
  NSString *result = nil;
  
  if (streetAddress) {
    result = streetAddress;
  } else if (streetNumber && streetName) {
    BOOL streetAddressStartsWithNumber = [streetValue hasPrefix:streetNumber];
    if (streetAddressStartsWithNumber) {
      result = [NSString stringWithFormat:@"%@ %@", streetNumber, streetName];
    } else {
      result = [NSString stringWithFormat:@"%@ %@", streetName, streetNumber];
    }
  } else if (streetName) {
    streetAddress = streetName;
  } else if (streetNumber) {
    streetAddress = streetNumber;
  } else {
    // keep all characters that are not a postal_code, city, state, or country
    NSMutableString *temp = [streetValue mutableCopy];
    for (NSString *key in @[@"postal_code", @"city", @"state", @"country"]) {
      NSString *value = [dict pk_objectForKey:key];
      if (value) {
        NSRange range = [temp rangeOfString:value options:NSBackwardsSearch];
        if (range.length > 0) {
          [temp deleteCharactersInRange:range];
        }
      }
    }
    
    result = [temp stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@", "]];
  }

  return result;
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
  location->_state = [_state copy];
  location->_mapInSync = [_mapInSync copy];
  
  return location;
}

#pragma mark - KVO

- (void)startObservingLocationValue {
  [self addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:kLocationValueChanged];
}

- (void)stopObservingLocationValue {
  [self removeObserver:self forKeyPath:@"value" context:kLocationValueChanged];
}

- (void)startObservingStructuredValues {
  for (NSString *keyPath in @[@"city", @"country", @"postalCode", @"streetAddress", @"state"]) {
    [self addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:kStructuredValueChanged];
  }
}

- (void)stopObservingStructuredValues {
  for (NSString *keyPath in @[@"city", @"country", @"postalCode", @"streetAddress", @"state"]) {
    [self removeObserver:self forKeyPath:keyPath context:kStructuredValueChanged];
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  if (context == kLocationValueChanged) {
    self.formatted = nil;
  } else if (context == kStructuredValueChanged) {
    NSMutableString *locationString = [NSMutableString new];
    
    if (self.streetAddress.length > 0) {
      [locationString appendString:self.streetAddress];
    }
    if (self.postalCode.length > 0) {
      if (locationString.length > 0) {
        [locationString appendFormat:@", %@", self.postalCode];
      } else {
        [locationString appendString:self.postalCode];
      }
    }
    if (self.city.length > 0) {
      if (locationString.length > 0) {
        NSString *format = self.postalCode.length > 0 ? @" %@" : @", %@";
        [locationString appendFormat:format, self.city];
      } else {
        [locationString appendString:self.city];
      }
    }
    if (self.state.length > 0) {
      if (locationString.length > 0) {
        [locationString appendFormat:@", %@", self.state];
      } else {
        [locationString appendString:self.state];
      }
    }
    if (self.country.length > 0) {
      if (locationString.length > 0) {
        [locationString appendFormat:@", %@", self.country];
      } else {
        [locationString appendString:self.country];
      }
    }
    
    self.value = locationString.length > 0 ? [locationString copy] : nil;
  }
}

@end
