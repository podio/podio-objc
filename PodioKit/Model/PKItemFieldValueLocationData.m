//
//  PKItemFieldValueLocationData.m
//  PodioKit
//
//  Created by Lauge Jepsen on 11/12/2014.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKItemFieldValueLocationData.h"

static NSString * const PKItemFieldValueLocationDataValueKey = @"ItemFieldValueLocationDataValue";
static NSString * const PKItemFieldValueLocationDataLatitudeKey = @"ItemFieldValueLocationDataLatitude";
static NSString * const PKItemFieldValueLocationDataLongitudeKey = @"ItemFieldValueLocationDataLongitude";


@implementation PKItemFieldValueLocationData

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _value = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataValueKey] copy];
    _latitude = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataLatitudeKey] copy];
    _longitude = [[aDecoder decodeObjectForKey:PKItemFieldValueLocationDataLongitudeKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:_value forKey:PKItemFieldValueLocationDataValueKey];
  [aCoder encodeObject:_latitude forKey:PKItemFieldValueLocationDataLatitudeKey];
  [aCoder encodeObject:_longitude forKey:PKItemFieldValueLocationDataLongitudeKey];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemFieldValueLocationData *data = [self data];
  
  data.value = [dict pk_objectForKey:@"value"];
  data.latitude = [dict pk_objectForKey:@"lat"];
  data.longitude = [dict pk_objectForKey:@"lng"];
  
  return data;
}

@end
