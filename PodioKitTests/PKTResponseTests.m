//
//  PKTResponseTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 15/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTResponse.h"

@interface PKTResponseTests : XCTestCase

@end

@implementation PKTResponseTests

- (void)testStringData {
  NSString *responseString = @"{\"key1\": \"value1\", \"key2\": \"value2\"}";
  NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
  PKTResponse *response = [[PKTResponse alloc] initWithData:data];
  
  expect(response.stringData).to.equal(responseString);
}

- (void)testParsedDataOfObject {
  NSString *responseString = @"{\"key1\": \"value1\", \"key2\": \"value2\"}";
  NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
  PKTResponse *response = [[PKTResponse alloc] initWithData:data];
  
  expect(response.parsedData).to.equal(@{
    @"key1" : @"value1",
    @"key2" : @"value2",
  });
}

- (void)testParsedDataOfArray {
  NSString *responseString = @"[{\"key1\": \"value1\", \"key2\": \"value2\"}]";
  NSData *data = [responseString dataUsingEncoding:NSUTF8StringEncoding];
  PKTResponse *response = [[PKTResponse alloc] initWithData:data];
  
  expect(response.parsedData).to.equal(@[@{
    @"key1" : @"value1",
    @"key2" : @"value2",
  }]);
}

@end
