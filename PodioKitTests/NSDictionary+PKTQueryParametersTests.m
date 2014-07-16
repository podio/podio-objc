//
//  NSDictionary+PKTQueryParametersTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 09/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSDictionary+PKTQueryParameters.h"

@interface NSDictionary_PKTQueryParametersTests : XCTestCase

@end

@implementation NSDictionary_PKTQueryParametersTests

- (void)testUnescapedSerializeQueryParameters {
  NSString *queryString = [@{@"email1" : @"name1@domain.com", @"email2" : @"name2@domain.com"} pkt_queryString];
  expect(queryString).to.equal(@"email2=name2@domain.com&email1=name1@domain.com");
}

- (void)testEscapedSerializeQueryParameters {
  NSString *queryString = [@{@"email1" : @"name1@domain.com", @"email2" : @"name2@domain.com"} pkt_escapedQueryString];
  expect(queryString).to.equal(@"email2=name2%40domain.com&email1=name1%40domain.com");
}

- (void)testNestedSerializeQueryParameters {
  NSDictionary *params = @{@"level1" : @{@"param1" : @"value1"},
                           @"level2" : @{@"level21" : @{@"param21" : @"value21"}},
                           @"param2" : @"value2",
                           };

  NSString *queryString = [params pkt_queryString];
  expect(queryString).to.contain(@"level1[param1]=value1");
  expect(queryString).to.contain(@"level2[level21][param21]=value21");
  expect(queryString).to.contain(@"param2=value2");
}

@end
