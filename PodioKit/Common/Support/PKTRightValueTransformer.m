//
//  PKTRightValueTransformer.m
//  PodioKit
//
//  Created by Romain Briche on 20/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKTRightValueTransformer.h"
#import "PKTConstants.h"

@implementation PKTRightValueTransformer

- (instancetype)init {
  return [self initWithBlock:^id(id value) {
    return @([PKTRightValueTransformer rightFromArray:value]);
  }];
}

#pragma mark - Private

+ (PKTRight)rightFromString:(NSString *)key {
  NSParameterAssert([key isKindOfClass:[NSString class]]);
  
  static NSDictionary *rightsMapping = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    rightsMapping = @{
      @"view": @(PKTRightView),
      @"update": @(PKTRightUpdate),
      @"delete": @(PKTRightDelete),
      @"subscribe": @(PKTRightSubscribe),
      @"comment": @(PKTRightComment),
      @"rate": @(PKTRightRate),
      @"share": @(PKTRightShare),
      @"install": @(PKTRightInstall),
      @"add_app": @(PKTRightAddApp),
      @"add_item": @(PKTRightAddItem),
      @"add_file": @(PKTRightAddFile),
      @"add_task": @(PKTRightAddTask),
      @"add_space": @(PKTRightAddSpace),
      @"add_status": @(PKTRightAddStatus),
      @"add_conversation": @(PKTRightAddConversation),
      @"reply": @(PKTRightReply),
      @"add_widget": @(PKTRightAddWidget),
      @"statistics": @(PKTRightStatistics),
      @"add_contact": @(PKTRightAddContact),
      @"add_hook": @(PKTRightAddHook),
      @"add_question": @(PKTRightAddQuestion),
      @"add_answer": @(PKTRightAddAnswer),
      @"add_contract": @(PKTRightAddContract),
      @"add_user": @(PKTRightAddUser),
      @"add_user_light": @(PKTRightAddUserLight),
      @"move": @(PKTRightMove),
      @"export": @(PKTRightExport),
      @"reference": @(PKTRightReference),
      @"view_admins": @(PKTRightViewAdmins),
      @"download": @(PKTRightDownload),
      @"grant": @(PKTRightGrant),
      @"grant_view": @(PKTRightGrantView)
    };
  });
  
  PKTRight right = PKTRightNone;
  NSValue *rightValue = rightsMapping[key];
  [rightValue getValue:&right];
  
  return right;
}

+ (PKTRight)rightFromArray:(NSArray *)keys {
  NSParameterAssert([keys isKindOfClass:[NSArray class]]);
  
  PKTRight right = PKTRightNone;
  for (NSString *key in keys) {
    right |= [self rightFromString:key];
  }
  
  return right;
}

@end
