//
//  PKTStatusAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 30/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTStatusAPI.h"

@interface PKTStatusAPITests : XCTestCase

@end

@implementation PKTStatusAPITests

- (void)testRequestForNewStatusMessageWithEmbedID {
  PKTRequest *request = [PKTStatusAPI requestToAddNewStatusMessageWithText:@"Some text" spaceID:1234 files:@[@111, @222] embedID:333];
  
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.path).to.equal(@"/status/space/1234/");
  expect(request.parameters[@"value"]).equal(@"Some text");
  expect(request.parameters[@"embed_id"]).equal(@333);;
  expect(request.parameters[@"file_ids"]).equal(@[@111, @222]);
}

- (void)testRequestForNewStatusMessageWithEmbedURL {
  PKTRequest *request = [PKTStatusAPI requestToAddNewStatusMessageWithText:@"Some text" spaceID:1234 files:@[@111, @222] embedURL:[NSURL URLWithString:@"https://www.podio.com"]];
  
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.path).to.equal(@"/status/space/1234/");
  expect(request.parameters[@"value"]).equal(@"Some text");
  expect(request.parameters[@"embed_url"]).equal(@"https://www.podio.com");
  expect(request.parameters[@"file_ids"]).equal(@[@111, @222]);
}

@end
