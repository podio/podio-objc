//
//  PKTLocation.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTLocation.h"

@implementation PKTLocation

- (instancetype)initWithFullDescription:(NSString *)fullDescription streetName:(NSString *)streetName city:(NSString *)city country:(NSString *)country latitude:(double)latitude longitude:(double)longitude {
  self = [super init];
  if (!self) return nil;
  
  _fullDescription = [fullDescription copy];
  _streetName = [streetName copy];
  _city = [city copy];
  _country = [country copy];
  _latitude = latitude;
  _longitude = longitude;
  
  return self;
}

#pragma mark - PKModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"fullDescription" : @"value",
           @"streetName" : @"street_name",
           };
}

@end
