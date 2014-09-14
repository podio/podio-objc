//
//  PKTNotificationsRequestParameters.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 08/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTNotificationsRequestParameters.h"
#import "NSValueTransformer+PKTConstants.h"
#import "NSValueTransformer+PKTTransformers.h"
#import "PKTDateValueTransformer.h"

@implementation PKTNotificationsRequestParameters

#pragma mark - PKTRequestParameters

- (NSDictionary *)queryParameters {
  NSMutableDictionary *params = [NSMutableDictionary new];
  
  if (self.userID > 0) {
    params[@"user_id"] = @(self.userID);
  }
  
  if (self.contextType != PKTReferenceTypeUnknown) {
    params[@"context_type"] = [NSValueTransformer pkt_stringFromReferenceType:self.contextType];
  }
  
  if (self.starred != PKTNotificationStarredStateDefault) {
    params[@"starred"] = @(self.starred == PKTNotificationStarredStateStarred);
  }
  
  if (self.viewed != PKTNotificationViewedStateDefault) {
    params[@"viewed"] = @(self.viewed == PKTNotificationViewedStateViewed);
  }
  
  if (self.direction != PKTNotificationDirectionDefault) {
    params[@"direction"] = self.direction == PKTNotificationDirectionOutgoing ? @"outgoing" : @"incoming";
  }
  
  PKTDateValueTransformer *dateTransformer = [PKTDateValueTransformer new];
  dateTransformer.ignoresTimeComponent = YES;
  
  if (self.createdFromDate) {
    params[@"created_from"] = [dateTransformer reverseTransformedValue:self.createdFromDate];
  }
  
  if (self.createdToDate) {
    params[@"created_to"] = [dateTransformer reverseTransformedValue:self.createdToDate];
  }
  
  if (self.viewedFromDate) {
    params[@"viewed_from"] = [dateTransformer reverseTransformedValue:self.viewedFromDate];
  }
  
  return [params copy];
}

@end
