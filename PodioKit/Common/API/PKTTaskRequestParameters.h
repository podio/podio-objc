//
//  PKTTaskRequestParameters.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PKTDateRange;
@class PKTReferenceIdentifier;

typedef NS_ENUM(NSUInteger, PKTTaskRequestParameterGrouping) {
  PKTTaskRequestParameterGroupingDefault,
  PKTTaskRequestParameterGroupingDueDate,
  PKTTaskRequestParameterGroupingCreatedBy,
  PKTTaskRequestParameterGroupingResponsible,
  PKTTaskRequestParameterGroupingApp,
  PKTTaskRequestParameterGroupingSpace,
  PKTTaskRequestParameterGroupingOrg
};

typedef NS_ENUM(NSUInteger, PKTTaskRequestParameterCompletedOn) {
  PKTTaskRequestParameterCompletedOnNone,
  PKTTaskRequestParameterCompletedOnToday,
  PKTTaskRequestParameterCompletedOn1Day,
  PKTTaskRequestParameterCompletedOn2Days,
  PKTTaskRequestParameterCompletedOn3Days,
  PKTTaskRequestParameterCompletedOn4Days,
  PKTTaskRequestParameterCompletedOn5Days,
  PKTTaskRequestParameterCompletedOn6Days,
  PKTTaskRequestParameterCompletedOn1Week,
  PKTTaskRequestParameterCompletedOn2Weeks,
  PKTTaskRequestParameterCompletedOn3Weeks,
  PKTTaskRequestParameterCompletedOn4Weeks,
  PKTTaskRequestParameterCompletedOn1Month,
  PKTTaskRequestParameterCompletedOn2Months,
  PKTTaskRequestParameterCompletedOn3Months,
  PKTTaskRequestParameterCompletedOn4Months,
  PKTTaskRequestParameterCompletedOn5Months,
  PKTTaskRequestParameterCompletedOn6Months,
  PKTTaskRequestParameterCompletedOn7Months,
  PKTTaskRequestParameterCompletedOn8Months,
  PKTTaskRequestParameterCompletedOn9Months,
  PKTTaskRequestParameterCompletedOn10Months,
  PKTTaskRequestParameterCompletedOn11Months,
  PKTTaskRequestParameterCompletedOn12Months,
  PKTTaskRequestParameterCompletedOn1Year,
  PKTTaskRequestParameterCompletedOnOlder,
};

typedef NS_ENUM(NSUInteger, PKTTaskRequestParameterSortBy) {
  PKTTaskRequestParameterSortByDefault,
  PKTTaskRequestParameterSortByRank,
  PKTTaskRequestParameterSortByCreatedBy,
  PKTTaskRequestParameterSortByCreatedOn
};

typedef NS_ENUM(NSUInteger, PKTTaskRequestParameterSortOrder) {
  PKTTaskRequestParameterSortOrderDefault,
  PKTTaskRequestParameterSortOrderAscending,
  PKTTaskRequestParameterSortOrderDescending
};


@interface PKTTaskRequestParameters : NSObject

@property (nonatomic, assign, readwrite) PKTTaskRequestParameterGrouping grouping;
@property (nonatomic, assign, readwrite) PKTTaskRequestParameterCompletedOn completedOn;
@property (nonatomic, assign, readwrite) PKTTaskRequestParameterSortBy sortBy;
@property (nonatomic, assign, readwrite) PKTTaskRequestParameterSortOrder sortOrder;
@property (nonatomic, assign, readwrite) NSUInteger responsibleUserID;
@property (nonatomic, copy, readwrite) PKTDateRange *dueDateRange;
@property (nonatomic, copy, readwrite) NSArray *references; // An array of PKTReferenceIdentifier
@property (nonatomic, copy, readonly) NSDictionary *queryParameters;

+ (instancetype)parameters;
+ (instancetype)parametersWithBlock:(void (^)(PKTTaskRequestParameters *params))block;

@end

