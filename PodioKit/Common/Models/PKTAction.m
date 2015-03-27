//
//  PKTAction.m
//  PodioKit
//
//  Created by Romain Briche on 27/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKTAction.h"
#import "PKTByLine.h"
#import "PKTComment.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTAction

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"actionID": @"action_id",
    @"actionType": @"type",
    @"createdOn": @"created_on",
    @"createdBy": @"created_by",
  };
}

#pragma mark - Value transformers

+ (NSValueTransformer *)actionTypeValueTransformer {
  return [NSValueTransformer pkt_transformerWithDictionary:@{
    @"space_created": @(PKTActionTypeSpaceCreated),
    @"member_added": @(PKTActionTypeMemberAdded),
    @"member_left": @(PKTActionTypeMemberLeft),
    @"member_kicked": @(PKTActionTypeMemberKicked),
    @"app_created": @(PKTActionTypeAppCreated),
    @"app_updated": @(PKTActionTypeAppUpdated),
    @"app_deleted": @(PKTActionTypeAppDeleted),
    @"app_installed": @(PKTActionTypeAppInstalled),
    @"app_activated": @(PKTActionTypeAppActivated),
    @"app_deactivated": @(PKTActionTypeAppDeactivated)
  }];
}

+ (NSValueTransformer *)createdOnValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)createdByValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTByLine class]];
}

+ (NSValueTransformer *)commentsValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTComment class]];
}

@end
