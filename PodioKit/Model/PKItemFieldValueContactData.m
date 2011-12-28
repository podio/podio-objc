//
//  POTransformableContactData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-07.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKItemFieldValueContactData.h"


static NSString * const POTransformableContactDataNameKey = @"Name";
static NSString * const POTransformableContactDataEmailKey = @"Email";
static NSString * const POTransformableContactDataTitleKey = @"Title";
static NSString * const POTransformableContactDataOrgKey = @"Org";
static NSString * const POTransformableContactDataUserIdKey = @"UserId";
static NSString * const POTransformableContactDataProfileIdKey = @"ProfileId";
static NSString * const POTransformableContactDataAvatarIdKey = @"AvatarId";

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
    name_ = [[aDecoder decodeObjectForKey:POTransformableContactDataNameKey] copy];
    email_ = [[aDecoder decodeObjectForKey:POTransformableContactDataEmailKey] copy];
    title_ = [[aDecoder decodeObjectForKey:POTransformableContactDataTitleKey] copy];
    organization_ = [[aDecoder decodeObjectForKey:POTransformableContactDataOrgKey] copy];
    userId_ = [aDecoder decodeIntegerForKey:POTransformableContactDataUserIdKey];
    profileId_ = [aDecoder decodeIntegerForKey:POTransformableContactDataProfileIdKey];
    avatarId_ = [aDecoder decodeIntegerForKey:POTransformableContactDataAvatarIdKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:name_ forKey:POTransformableContactDataNameKey];
  [aCoder encodeObject:email_ forKey:POTransformableContactDataEmailKey];
  [aCoder encodeObject:title_ forKey:POTransformableContactDataTitleKey];
  [aCoder encodeObject:organization_ forKey:POTransformableContactDataOrgKey];
  [aCoder encodeInteger:userId_ forKey:POTransformableContactDataUserIdKey];
  [aCoder encodeInteger:profileId_ forKey:POTransformableContactDataProfileIdKey];
  [aCoder encodeInteger:avatarId_ forKey:POTransformableContactDataAvatarIdKey];
}

- (void)dealloc {
  [name_ release];
  [email_ release];
  [title_ release];
  [organization_ release];
  [super dealloc];
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
