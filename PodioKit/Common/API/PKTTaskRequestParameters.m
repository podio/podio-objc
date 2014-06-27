//
//  PKTTaskRequestParameters.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTTaskRequestParameters.h"
#import "PKTDateRange.h"
#import "PKTReferenceIdentifier.h"
#import "NSArray+PKTAdditions.h"
#import "NSValueTransformer+PKTConstants.h"
#import "NSDate+PKTAdditions.h"

@implementation PKTTaskRequestParameters

- (NSDictionary *)queryParameters {
  NSMutableDictionary *params = [NSMutableDictionary new];
  
  // Grouping
  if (self.grouping != PKTTaskRequestParameterGroupingDefault) {
    params[@"grouping"] = [[self class] groupingMap][@(self.grouping)];
  }
  
  // Sort by
  if (self.sortBy != PKTTaskRequestParameterSortByDefault) {
    params[@"sort_by"] = [[self class] sortByMap][@(self.sortBy)];
  }
  
  // Sort order
  if (self.sortOrder != PKTTaskRequestParameterSortOrderDefault) {
    params[@"sort_desc"] = self.sortOrder == PKTTaskRequestParameterSortOrderDescending ? @YES : @NO;
  }
  
  // Completed on
  if (self.completedOn != PKTTaskRequestParameterCompletedOnNone) {
    params[@"completed_on"] = [[self class] completedOnMap][@(self.completedOn)];
  }
  
  // Responsible
  if (self.responsibleUserID > 0) {
    params[@"responsible"] = @(self.responsibleUserID);
  }
  
  // Due date
  if (self.dueDateRange && self.dueDateRange.startDate) {
    params[@"due_date"] = [self dueDateString];
  }
  
  // Reference
  if ([self.references count] > 0) {
    params[@"reference"] = [self referenceString];
  }
  
  return params;
}

+ (NSDictionary *)groupingMap {
  static NSDictionary *map = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    map = @{
            @(PKTTaskRequestParameterGroupingDueDate) : @"due_date",
            @(PKTTaskRequestParameterGroupingCreatedBy) : @"created_by",
            @(PKTTaskRequestParameterGroupingResponsible) : @"responsible",
            @(PKTTaskRequestParameterGroupingApp) : @"app",
            @(PKTTaskRequestParameterGroupingSpace) : @"space",
            @(PKTTaskRequestParameterGroupingOrg) : @"org"
            };
  });
  
  return map;
}

+ (NSDictionary *)sortByMap {
  static NSDictionary *map = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    map = @{
            @(PKTTaskRequestParameterSortByRank) : @"rank",
            @(PKTTaskRequestParameterSortByCreatedBy) : @"created_by",
            @(PKTTaskRequestParameterSortByCreatedOn) : @"created_on"
            };
  });
  
  return map;
}

+ (NSDictionary *)completedOnMap {
  static NSDictionary *map = nil;
  
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    map = @{
            @(PKTTaskRequestParameterCompletedOnToday) : @"today",
            @(PKTTaskRequestParameterCompletedOn1Day) : @"1_day",
            @(PKTTaskRequestParameterCompletedOn2Days) : @"2_days",
            @(PKTTaskRequestParameterCompletedOn3Days) : @"3_days",
            @(PKTTaskRequestParameterCompletedOn4Days) : @"4_days",
            @(PKTTaskRequestParameterCompletedOn5Days) : @"5_days",
            @(PKTTaskRequestParameterCompletedOn6Days) : @"6_days",
            @(PKTTaskRequestParameterCompletedOn1Week) : @"1_week",
            @(PKTTaskRequestParameterCompletedOn2Weeks) : @"2_weeks",
            @(PKTTaskRequestParameterCompletedOn3Weeks) : @"3_weeks",
            @(PKTTaskRequestParameterCompletedOn4Weeks) : @"4_weeks",
            @(PKTTaskRequestParameterCompletedOn1Month) : @"1_month",
            @(PKTTaskRequestParameterCompletedOn2Months) : @"2_months",
            @(PKTTaskRequestParameterCompletedOn3Months) : @"3_months",
            @(PKTTaskRequestParameterCompletedOn4Months) : @"4_months",
            @(PKTTaskRequestParameterCompletedOn5Months) : @"5_months",
            @(PKTTaskRequestParameterCompletedOn6Months) : @"6_months",
            @(PKTTaskRequestParameterCompletedOn7Months) : @"7_months",
            @(PKTTaskRequestParameterCompletedOn8Months) : @"8_months",
            @(PKTTaskRequestParameterCompletedOn9Months) : @"9_months",
            @(PKTTaskRequestParameterCompletedOn10Months) : @"10_months",
            @(PKTTaskRequestParameterCompletedOn11Months) : @"11_months",
            @(PKTTaskRequestParameterCompletedOn12Months) : @"12_months",
            @(PKTTaskRequestParameterCompletedOn1Year) : @"1_year",
            @(PKTTaskRequestParameterCompletedOnOlder) : @"older",
            };
  });
  
  return map;
}

- (NSString *)dueDateString {
  NSMutableString *rangeString = [NSMutableString stringWithString:[self.dueDateRange.startDate pkt_UTCDateString]];
  if (self.dueDateRange.endDate) {
    [rangeString appendFormat:@"-%@", [self.dueDateRange.endDate pkt_UTCDateString]];
  }
  
  return [rangeString copy];
}

- (NSString *)referenceString {
  // Turn PKTReferenceIdentifiers into comma separated list of "ref_type:ref_id" format strings
  return [[self.references pkt_mappedArrayWithBlock:^id(PKTReferenceIdentifier *identifier) {
    return [NSString stringWithFormat:@"%@:%@", identifier.referenceTypeString, @(identifier.referenceID)];
  }] componentsJoinedByString:@","];
}

#pragma mark - Public

+ (instancetype)parameters {
  return [self new];
}

+ (instancetype)parametersWithBlock:(void (^)(PKTTaskRequestParameters *params))block {
  PKTTaskRequestParameters *params = [PKTTaskRequestParameters parameters];
  if (block) block(params);
  
  return params;
}

@end
