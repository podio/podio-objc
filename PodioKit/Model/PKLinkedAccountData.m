//
//  PKLinkedAccountData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/29/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKLinkedAccountData.h"

static NSString * const PKLinkedAccountDataLinkedAccountIdKey = @"LinkedAccountId";
static NSString * const PKLinkedAccountDataLabelKey = @"Label";
static NSString * const PKLinkedAccountDataProviderKey = @"Provider";
static NSString * const PKLinkedAccountDataProviderHumanizedNameKey = @"ProviderHumanizedName";

@implementation PKLinkedAccountData

@synthesize linkedAccountId = linkedAccountId_;
@synthesize label = label_;
@synthesize provider = provider_;
@synthesize providerHumanizedName = providerHumanizedName_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    linkedAccountId_ = [aDecoder decodeIntegerForKey:PKLinkedAccountDataLinkedAccountIdKey];
    label_ = [[aDecoder decodeObjectForKey:PKLinkedAccountDataLabelKey] copy];
    provider_ = [[aDecoder decodeObjectForKey:PKLinkedAccountDataProviderKey] copy];
    providerHumanizedName_ = [[aDecoder decodeObjectForKey:PKLinkedAccountDataProviderHumanizedNameKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:linkedAccountId_ forKey:PKLinkedAccountDataLinkedAccountIdKey];
  [aCoder encodeObject:label_ forKey:PKLinkedAccountDataLabelKey];
  [aCoder encodeObject:provider_ forKey:PKLinkedAccountDataProviderKey];
  [aCoder encodeObject:providerHumanizedName_ forKey:PKLinkedAccountDataProviderHumanizedNameKey];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKLinkedAccountData *data = [self data];
  
  data.linkedAccountId = [[dict pk_objectForKey:@"linked_account_id"] integerValue];
  data.label = [dict pk_objectForKey:@"label"];
  data.provider = [dict pk_objectForKey:@"provider"];
  data.providerHumanizedName = [dict pk_objectForKey:@"provider_humanized_name"];
  
  return data;
}

@end
