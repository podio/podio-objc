//
//  PKTValueTransformersTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 15/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSValueTransformer+PKTTransformers.h"
#import "PKTTestModel.h"
#import "PKTReversibleBlockValueTransformer.h"
#import "PKTModelValueTransformer.h"
#import "PKTURLValueTransformer.h"
#import "PKTReferenceTypeValueTransformer.h"
#import "PKTNotificationTypeValueTransformer.h"
#import "PKTRightValueTransformer.h"
#import "PKTAvatarTypeValueTransformer.h"

@interface NSValueTransformer_PKTTransformers : XCTestCase

@end

@implementation NSValueTransformer_PKTTransformers

- (void)testBlockTransformer {
  NSValueTransformer *transformer = [NSValueTransformer pkt_transformerWithBlock:^id(id value) {
    return nil;
  }];
  
  expect(transformer).to.beInstanceOf([PKTBlockValueTransformer class]);
}

- (void)testReversibleBlockTransformer {
  NSValueTransformer *transformer = [NSValueTransformer pkt_transformerWithBlock:^id(id value) {
    return nil;
  } reverseBlock:^id(id value) {
    return nil;
  }];
  
  expect(transformer).to.beInstanceOf([PKTReversibleBlockValueTransformer class]);
}

- (void)testModelTransformer {
  NSValueTransformer *transformer = [NSValueTransformer pkt_transformerWithModelClass:[PKTTestModel class]];
  
  expect(transformer).to.beInstanceOf([PKTModelValueTransformer class]);
}

- (void)testURLTransformer {
  NSValueTransformer *transformer = [NSValueTransformer pkt_URLTransformer];
  expect(transformer).to.beInstanceOf([PKTURLValueTransformer class]);
}

- (void)testReferenceTypeTransformer {
  NSValueTransformer *transformer = [NSValueTransformer pkt_referenceTypeTransformer];
  expect(transformer).to.beInstanceOf([PKTReferenceTypeValueTransformer class]);
}

- (void)testNotificationTypeTransformer {
  NSValueTransformer *transformer = [NSValueTransformer pkt_notificationTypeTransformer];
  expect(transformer).to.beInstanceOf([PKTNotificationTypeValueTransformer class]);
}

- (void)testRightTransformer {
  NSValueTransformer *transformer = [NSValueTransformer pkt_rightValueTransformer];
  expect(transformer).to.beInstanceOf([PKTRightValueTransformer class]);
}

- (void)testAvatarTypeTransformer {
  NSValueTransformer *transformer = [NSValueTransformer pkt_avatarTypeValueTransformer];
  expect(transformer).to.beInstanceOf([PKTAvatarTypeValueTransformer class]);
}

@end
