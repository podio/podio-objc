//
//  PKLinkedAccountData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/29/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKLinkedAccountData.h"

static NSString * const PKLinkedAccountDataLinkedAccountIdKey = @"LinkedAccountId";
static NSString * const PKLinkedAccountDataLabelKey = @"Label";
static NSString * const PKLinkedAccountDataProviderKey = @"Provider";

@implementation PKLinkedAccountData

@synthesize linkedAccountId = linkedAccountId_;
@synthesize label = label_;
@synthesize provider = provider_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    linkedAccountId_ = [aDecoder decodeIntegerForKey:PKLinkedAccountDataLinkedAccountIdKey];
    label_ = [[aDecoder decodeObjectForKey:PKLinkedAccountDataLabelKey] copy];
    provider_ = [[aDecoder decodeObjectForKey:PKLinkedAccountDataProviderKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:linkedAccountId_ forKey:PKLinkedAccountDataLinkedAccountIdKey];
  [aCoder encodeObject:label_ forKey:PKLinkedAccountDataLabelKey];
  [aCoder encodeObject:provider_ forKey:PKLinkedAccountDataProviderKey];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKLinkedAccountData *data = [self data];
  
  data.linkedAccountId = [[dict pk_objectForKey:@"linked_account_id"] integerValue];
  data.label = [dict pk_objectForKey:@"label"];
  data.provider = [dict pk_objectForKey:@"provider"];
  
  return data;
}

@end
