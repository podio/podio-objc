//
//  PKTLocation.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTLocation.h"
#import "PKTLocationAPI.h"
#import "NSArray+PKTAdditions.h"
#import "PKTClient.h"

@implementation PKTLocation

- (instancetype)initWithValue:(NSString *)value
               formattedValue:(NSString *)formattedValue
                   streetName:(NSString *)streetName
                 streetNumber:(NSString *)streetNumber
                   postalCode:(NSString *)postalCode
                         city:(NSString *)city
                        state:(NSString *)state
                      country:(NSString *)country
                     latitude:(PKTLocationCoordinate)latitude
                    longitude:(PKTLocationCoordinate)longitude {
  self = [super init];
  if (!self) return nil;
  
  _value = [value copy];
  _formattedValue = [formattedValue copy];
  _streetName = [streetName copy];
  _streetNumber = [streetNumber copy];
  _postalCode = [postalCode copy];
  _city = [city copy];
  _state = [state copy];
  _country = [country copy];
  _latitude = latitude;
  _longitude = longitude;
  
  return self;
}

- (instancetype)initWithValue:(NSString *)value {
  return [self initWithValue:value
              formattedValue:nil
                  streetName:nil
                streetNumber:nil
                  postalCode:nil
                        city:nil
                       state:nil
                     country:nil
                    latitude:0
                   longitude:0];
}

- (instancetype)initWithLatitude:(PKTLocationCoordinate)latitude longitude:(PKTLocationCoordinate)longitude {
  return [self initWithValue:nil
              formattedValue:nil
                  streetName:nil
                streetNumber:nil
                  postalCode:nil
                        city:nil
                       state:nil
                     country:nil
                    latitude:latitude
                   longitude:longitude];
}

#pragma mark - PKModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"value" : @"value",
           @"formattedValue" : @"formatted",
           @"streetName" : @"street_name",
           @"streetNumber" : @"street_number",
           @"postalCode" : @"postal_code",
           @"latitude" : @"lat",
           @"longitude" : @"lng",
           };
}

#pragma mark - Computed properties

- (NSString *)streetAddress {
  return self.streetNumber ? [NSString stringWithFormat:@"%@ %@", self.streetName, self.streetNumber] : self.streetName;
}

#pragma mark - API calls

+ (PKTAsyncTask *)lookupAddress:(NSString *)addressString {
  PKTRequest *request = [PKTLocationAPI requestToLookupLoactionWithAddressString:addressString];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  PKTAsyncTask *task = [requestTask map:^id(PKTResponse *response) {
    return [response.body pkt_mappedArrayWithBlock:^id(NSDictionary *dict) {
      return [[PKTLocation alloc] initWithDictionary:dict];
    }];
  }];
  
  return task;
}

@end
