//
//  PKGrantData.m
//  PodioKit
//
//  Created by Romain Briche on 28/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKGrantData.h"

static NSString * const kPKReferenceGrantDataGrantIdKey = @"GrantId";
static NSString * const kPKReferenceGrantDataActionKey = @"Action";
static NSString * const kPKReferenceGrantDataMessageKey = @"Message";
static NSString * const kPKReferenceGrantDataCreatedOnKey = @"CreatedOn";
static NSString * const kPKReferenceGrantDataCreatedByKey = @"CreatedBy";
static NSString * const kPKReferenceGrantDataReferenceTypeKey = @"ReferenceType";
static NSString * const kPKReferenceGrantDataReferenceIdKey = @"ReferenceId";
static NSString * const kPKReferenceGrantDataReferenceDataKey = @"ReferenceData";

@interface PKGrantData ()

@property (nonatomic, assign, readwrite) NSUInteger grantId;
@property (nonatomic, assign, readwrite) PKGrantAction action;
@property (nonatomic, copy, readwrite) NSString *message;
@property (nonatomic, copy, readwrite) NSDate *createdOn;
@property (nonatomic, strong, readwrite) PKByLineData *createdBy;
@property (nonatomic, assign, readwrite) PKReferenceType referenceType;
@property (nonatomic, assign, readwrite) NSUInteger referenceId;
@property (nonatomic, strong, readwrite) PKObjectData *referenceData;

@end

@implementation PKGrantData

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (!self) return nil;

  _grantId = [aDecoder decodeIntForKey:kPKReferenceGrantDataGrantIdKey];
  _action = [aDecoder decodeIntForKey:kPKReferenceGrantDataActionKey];
  _message = [[aDecoder decodeObjectForKey:kPKReferenceGrantDataMessageKey] copy];
  _createdOn = [[aDecoder decodeObjectForKey:kPKReferenceGrantDataCreatedOnKey] copy];
  _createdBy = [aDecoder decodeObjectForKey:kPKReferenceGrantDataCreatedByKey];
  _referenceType = [aDecoder decodeIntForKey:kPKReferenceGrantDataReferenceTypeKey];
  _referenceId = [aDecoder decodeIntForKey:kPKReferenceGrantDataReferenceIdKey];
  _referenceData = [aDecoder decodeObjectForKey:kPKReferenceGrantDataReferenceDataKey];

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:_grantId forKey:kPKReferenceGrantDataGrantIdKey];
  [aCoder encodeInteger:_action forKey:kPKReferenceGrantDataActionKey];
  [aCoder encodeObject:_message forKey:kPKReferenceGrantDataMessageKey];
  [aCoder encodeObject:_createdOn forKey:kPKReferenceGrantDataCreatedOnKey];
  [aCoder encodeObject:_createdBy forKey:kPKReferenceGrantDataCreatedByKey];
  [aCoder encodeInteger:_referenceType forKey:kPKReferenceGrantDataReferenceTypeKey];
  [aCoder encodeInteger:_referenceId forKey:kPKReferenceGrantDataReferenceIdKey];
  [aCoder encodeObject:_referenceData forKey:kPKReferenceGrantDataReferenceDataKey];
}


#pragma mark - PKObjectData

+ (instancetype)dataFromDictionary:(NSDictionary *)dict {
  PKGrantData *grant = [self data];

  grant.grantId = [[dict pk_objectForKey:@"grant_id"] unsignedIntegerValue];
  grant.action = [PKConstants grantActionForString:[dict pk_objectForKey:@"action"]];
  grant.message = [dict pk_objectForKey:@"message"];
  grant.createdOn = [NSDate pk_dateFromUTCDateTimeString:[dict pk_objectForKey:@"created_on"]];
  grant.createdBy = [PKByLineData dataFromDictionary:[dict pk_objectForKey:@"created_by"]];

  NSDictionary *refDict = [dict pk_objectForKey:@"ref"];
  grant.referenceType = [PKConstants referenceTypeForString:[refDict pk_objectForKey:@"type"]];
  grant.referenceId = [[refDict pk_objectForKey:@"id"] unsignedIntegerValue];
  grant.referenceData = [PKReferenceDataFactory dataForDictionary:[refDict pk_objectForKey:@"data"] referenceType:grant.referenceType];

  return grant;
}

@end
