//
//  PKTRightValueTransformerTests.m
//  PodioKit
//
//  Created by Romain Briche on 20/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTRightValueTransformer.h"
#import "PKTConstants.h"

@interface PKTRightValueTransformerTests : XCTestCase

@end

@implementation PKTRightValueTransformerTests

- (void)testTransformRightStrings {
  PKTRightValueTransformer *transformer = [PKTRightValueTransformer new];
  
  void (^testRights)(NSArray *, PKTRight, BOOL) = ^(NSArray *values, PKTRight rightsToTest, BOOL expectedToBeValid) {
    PKTRight rights;
    NSValue *transformedValue = [transformer transformedValue:values];
    [transformedValue getValue:&rights];
    
    expect(!!(rights & rightsToTest)).to.equal(expectedToBeValid);
  };
  
  testRights(@[@"view"], PKTRightView, YES);
  testRights(@[@"update"], PKTRightUpdate, YES);
  testRights(@[@"delete"], PKTRightDelete, YES);
  testRights(@[@"subscribe"], PKTRightSubscribe, YES);
  testRights(@[@"comment"], PKTRightComment, YES);
  testRights(@[@"rate"], PKTRightRate, YES);
  testRights(@[@"share"], PKTRightShare, YES);
  testRights(@[@"install"], PKTRightInstall, YES);
  testRights(@[@"add_app"], PKTRightAddApp, YES);
  testRights(@[@"add_item"], PKTRightAddItem, YES);
  testRights(@[@"add_file"], PKTRightAddFile, YES);
  testRights(@[@"add_task"], PKTRightAddTask, YES);
  testRights(@[@"add_space"], PKTRightAddSpace, YES);
  testRights(@[@"add_status"], PKTRightAddStatus, YES);
  testRights(@[@"add_conversation"], PKTRightAddConversation, YES);
  testRights(@[@"reply"], PKTRightReply, YES);
  testRights(@[@"add_widget"], PKTRightAddWidget, YES);
  testRights(@[@"statistics"], PKTRightStatistics, YES);
  testRights(@[@"add_contact"], PKTRightAddContact, YES);
  testRights(@[@"add_hook"], PKTRightAddHook, YES);
  testRights(@[@"add_question"], PKTRightAddQuestion, YES);
  testRights(@[@"add_answer"], PKTRightAddAnswer, YES);
  testRights(@[@"add_contract"], PKTRightAddContract, YES);
  testRights(@[@"add_user"], PKTRightAddUser, YES);
  testRights(@[@"add_user_light"], PKTRightAddUserLight, YES);
  testRights(@[@"move"], PKTRightMove, YES);
  testRights(@[@"export"], PKTRightExport, YES);
  testRights(@[@"reference"], PKTRightReference, YES);
  testRights(@[@"view_admins"], PKTRightViewAdmins, YES);
  testRights(@[@"download"], PKTRightDownload, YES);
  testRights(@[@"grant"], PKTRightGrant, YES);
  testRights(@[@"grant_view"], PKTRightGrantView, YES);

  NSArray *values = @[@"view"];
  testRights(values, PKTRightView, YES);
  testRights(values, PKTRightUpdate, NO);
  testRights(values, PKTRightDelete, NO);
  testRights(values, PKTRightSubscribe, NO);
  testRights(values, PKTRightComment, NO);
  testRights(values, PKTRightRate, NO);
  testRights(values, PKTRightShare, NO);
  testRights(values, PKTRightInstall, NO);
  testRights(values, PKTRightAddApp, NO);
  testRights(values, PKTRightAddItem, NO);
  testRights(values, PKTRightAddFile, NO);
  testRights(values, PKTRightAddTask, NO);
  testRights(values, PKTRightAddSpace, NO);
  testRights(values, PKTRightAddStatus, NO);
  testRights(values, PKTRightAddConversation, NO);
  testRights(values, PKTRightReply, NO);
  testRights(values, PKTRightAddWidget, NO);
  testRights(values, PKTRightStatistics, NO);
  testRights(values, PKTRightAddContact, NO);
  testRights(values, PKTRightAddHook, NO);
  testRights(values, PKTRightAddQuestion, NO);
  testRights(values, PKTRightAddAnswer, NO);
  testRights(values, PKTRightAddContract, NO);
  testRights(values, PKTRightAddUser, NO);
  testRights(values, PKTRightAddUserLight, NO);
  testRights(values, PKTRightMove, NO);
  testRights(values, PKTRightExport, NO);
  testRights(values, PKTRightReference, NO);
  testRights(values, PKTRightViewAdmins, NO);
  testRights(values, PKTRightDownload, NO);
  testRights(values, PKTRightGrant, NO);
  testRights(values, PKTRightGrantView, NO);

  values = @[@"add_conversation", @"rate", @"add_task", @"comment", @"view", @"update", @"add_file", @"grant_view", @"subscribe", @"grant"];
  testRights(values, PKTRightAddConversation, YES);
  testRights(values, PKTRightRate, YES);
  testRights(values, PKTRightAddTask, YES);
  testRights(values, PKTRightComment, YES);
  testRights(values, PKTRightView, YES);
  testRights(values, PKTRightUpdate, YES);
  testRights(values, PKTRightAddFile, YES);
  testRights(values, PKTRightGrantView, YES);
  testRights(values, PKTRightSubscribe, YES);
  testRights(values, PKTRightGrant, YES);
  testRights(values, PKTRightDelete, NO);
  testRights(values, PKTRightShare, NO);
  testRights(values, PKTRightInstall, NO);
  testRights(values, PKTRightAddApp, NO);
  testRights(values, PKTRightAddItem, NO);
  testRights(values, PKTRightAddSpace, NO);
  testRights(values, PKTRightAddStatus, NO);
  testRights(values, PKTRightReply, NO);
  testRights(values, PKTRightAddWidget, NO);
  testRights(values, PKTRightStatistics, NO);
  testRights(values, PKTRightAddContact, NO);
  testRights(values, PKTRightAddHook, NO);
  testRights(values, PKTRightAddQuestion, NO);
  testRights(values, PKTRightAddAnswer, NO);
  testRights(values, PKTRightAddContract, NO);
  testRights(values, PKTRightAddUser, NO);
  testRights(values, PKTRightAddUserLight, NO);
  testRights(values, PKTRightMove, NO);
  testRights(values, PKTRightExport, NO);
  testRights(values, PKTRightReference, NO);
  testRights(values, PKTRightViewAdmins, NO);
  testRights(values, PKTRightDownload, NO);
}

@end
