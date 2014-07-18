//
//  PKTCommentAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTCommentsAPI.h"

@interface PKTCommentAPITests : XCTestCase

@end

@implementation PKTCommentAPITests

- (void)testExample {
  NSURL *embedURL = [NSURL URLWithString:@"https://www.google.com"];
  PKTRequest *request = [PKTCommentsAPI requestToAddCommentToObjectWithReferenceID:123
                                                                    referenceType:PKTReferenceTypeItem
                                                                            value:@"Some text"
                                                                            files:@[@1, @2]
                                                                          embedID:222
                                                                         embedURL:embedURL];
  expect(request.path).to.equal(@"/comment/item/123/");
  expect(request.parameters[@"value"]).to.equal(@"Some text");
  expect(request.parameters[@"file_ids"]).to.equal(@[@1, @2]);
  expect(request.parameters[@"embed_id"]).to.equal(222);
  expect(request.parameters[@"embed_url"]).to.equal([embedURL absoluteString]);
}

@end
