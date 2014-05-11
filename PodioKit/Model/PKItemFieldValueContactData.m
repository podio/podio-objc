//
//  PKItemFieldValueContactData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-07.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKItemFieldValueContactData.h"


static NSString * const PKItemFieldValueContactDataNameKey = @"Name";
static NSString * const PKItemFieldValueContactDataEmailKey = @"Email";
static NSString * const PKItemFieldValueContactDataTitleKey = @"Title";
static NSString * const PKItemFieldValueContactDataOrgKey = @"Org";
static NSString * const PKItemFieldValueContactDataUserIdKey = @"UserId";
static NSString * const PKItemFieldValueContactDataProfileIdKey = @"ProfileId";
static NSString * const PKItemFieldValueContactDataAvatarIdKey = @"AvatarId";

@implementation PKItemFieldValueContactData

@synthesize name = name_;
@synthesize email = email_;
@synthesize title = title_;
@synthesize organization = organization_;
@synthesize userId = userId_;
@synthesize profileId = profileId_;
@synthesize avatarId = avatarId_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    name_ = [[aDecoder decodeObjectForKey:PKItemFieldValueContactDataNameKey] copy];
    email_ = [[aDecoder decodeObjectForKey:PKItemFieldValueContactDataEmailKey] copy];
    title_ = [[aDecoder decodeObjectForKey:PKItemFieldValueContactDataTitleKey] copy];
    organization_ = [[aDecoder decodeObjectForKey:PKItemFieldValueContactDataOrgKey] copy];
    userId_ = [aDecoder decodeIntegerForKey:PKItemFieldValueContactDataUserIdKey];
    profileId_ = [aDecoder decodeIntegerForKey:PKItemFieldValueContactDataProfileIdKey];
    avatarId_ = [aDecoder decodeIntegerForKey:PKItemFieldValueContactDataAvatarIdKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:name_ forKey:PKItemFieldValueContactDataNameKey];
  [aCoder encodeObject:email_ forKey:PKItemFieldValueContactDataEmailKey];
  [aCoder encodeObject:title_ forKey:PKItemFieldValueContactDataTitleKey];
  [aCoder encodeObject:organization_ forKey:PKItemFieldValueContactDataOrgKey];
  [aCoder encodeInteger:userId_ forKey:PKItemFieldValueContactDataUserIdKey];
  [aCoder encodeInteger:profileId_ forKey:PKItemFieldValueContactDataProfileIdKey];
  [aCoder encodeInteger:avatarId_ forKey:PKItemFieldValueContactDataAvatarIdKey];
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
  if (![object isKindOfClass:[self class]]) return NO;
  
  PKItemFieldValueContactData *data = object;
  
  return data.profileId == self.profileId;
}

- (NSUInteger)hash {
  return [@(self.profileId) hash];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemFieldValueContactData *data = [self data];
  
  NSDictionary *refDict = [dict pk_objectForKey:@"value"];
  
  data.name = [refDict pk_objectForKey:@"name"];
  data.organization = [refDict pk_objectForKey:@"organization"];
  data.userId = [[refDict pk_objectForKey:@"user_id"] integerValue];
  data.profileId = [[refDict pk_objectForKey:@"profile_id"] integerValue];
  data.avatarId = [[refDict pk_objectForKey:@"avatar"] integerValue];
  
  NSArray *emails = [refDict pk_objectForKey:@"mail"];
  data.email = emails != nil && [emails count] > 0 ? [emails objectAtIndex:0] : nil;
  
  NSArray *titles = [refDict pk_objectForKey:@"title"];
  data.title = titles != nil && [titles count] > 0 ? [titles objectAtIndex:0] : nil;
  
  return data;
}

@end
