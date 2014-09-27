//
//  PKTLocationTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTLocation.h"

@interface PKTLocationTests : XCTestCase

@end

@implementation PKTLocationTests

- (void)testInitFromDictionary {
  NSDictionary *dict = @{
    @"city": @"Copenhagen",
    @"country": @"Denmark",
    @"street_name": @"Fisketorvet",
    @"formatted": @"Fisketorvet, 1560 Copenhagen, Denmark",
    @"value": @"Fisketorvet, 1560 Copenhagen, Denmark",
    @"postal_code": @"1560",
    @"lat": @55.6646305,
    @"lng": @12.5657289
  };
  
  PKTLocation *location = [[PKTLocation alloc] initWithDictionary:dict];
  expect(location.value).to.equal(@"Fisketorvet, 1560 Copenhagen, Denmark");
  expect(location.formattedValue).to.equal(@"Fisketorvet, 1560 Copenhagen, Denmark");
  expect(location.postalCode).to.equal(@"1560");
  expect(location.city).to.equal(@"Copenhagen");
  expect(location.country).to.equal(@"Denmark");
  expect(location.streetName).to.equal(@"Fisketorvet");
  expect(location.latitude).to.equal(55.6646305);
  expect(location.longitude).to.equal(12.5657289);
}

@end
