//
//  PKTEmbedsAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTEmbedsAPI.h"

@interface PKTEmbedsAPITests : XCTestCase

@end

@implementation PKTEmbedsAPITests

- (void)testRequestToAddEmbed {
  PKTRequest *request = [PKTEmbedsAPI requestToAddEmbedWithURLString:@"https://www.google.com"];
  
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.path).to.equal(@"/embed/");
  expect(request.parameters[@"url"]).to.equal(@"https://www.google.com");
}

@end
