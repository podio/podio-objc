//
//  PKTAvatarTypeValueTransformerTests.m
//  PodioKit
//
//  Created by Romain Briche on 21/04/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "PKTAvatarTypeValueTransformer.h"
#import "PKTConstants.h"

@interface PKTAvatarTypeValueTransformerTests : XCTestCase

@end

@implementation PKTAvatarTypeValueTransformerTests

- (void)testAvatarTypesValueTransformation {
  PKTAvatarTypeValueTransformer *transformer = [PKTAvatarTypeValueTransformer new];
  expect([transformer transformedValue:@"icon"]).to.equal(PKTAvatarTypeIcon);
  expect([transformer transformedValue:@"file"]).to.equal(PKTAvatarTypeFile);
}
@end
