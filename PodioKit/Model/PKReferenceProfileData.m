//
//  PKReferenceProfileData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/1/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKReferenceProfileData.h"


static NSString * const PKReferenceProfileDataProfileId = @"ProfileId";
static NSString * const PKReferenceProfileDataUserId = @"UserId";
static NSString * const PKReferenceProfileDataName = @"Name";
static NSString * const PKReferenceProfileDataType = @"Type";
static NSString * const PKReferenceProfileDataAvatarId = @"AvatarId";

@implementation PKReferenceProfileData


@synthesize profileId = profileId_;
@synthesize userId = userId_;
@synthesize name = name_;
@synthesize type = type_;
@synthesize avatarId = avatarId_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    profileId_ = [aDecoder decodeIntForKey:PKReferenceProfileDataProfileId];
    userId_ = [aDecoder decodeIntForKey:PKReferenceProfileDataUserId];
    name_ = [[aDecoder decodeObjectForKey:PKReferenceProfileDataName] copy];
    type_ = [aDecoder decodeIntForKey:PKReferenceProfileDataType];
    avatarId_ = [aDecoder decodeIntForKey:PKReferenceProfileDataAvatarId];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:profileId_ forKey:PKReferenceProfileDataProfileId];
  [aCoder encodeInteger:userId_ forKey:PKReferenceProfileDataUserId];
  [aCoder encodeObject:name_ forKey:PKReferenceProfileDataName];
  [aCoder encodeInteger:type_ forKey:PKReferenceProfileDataType];
  [aCoder encodeInteger:avatarId_ forKey:PKReferenceProfileDataAvatarId];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceProfileData *data = [self data];
  
  NSDictionary *userDict = [dict pk_objectForKey:@"user"];
  data.profileId = [[userDict pk_objectForKey:@"profile_id"] integerValue];
  data.userId = [[userDict pk_objectForKey:@"user_id"] integerValue];
  data.name = [userDict pk_objectForKey:@"name"];
  data.type = [PKConstants referenceTypeForString:[userDict pk_objectForKey:@"type"]];
  data.avatarId = [[userDict pk_objectForKey:@"avatar"] integerValue];
  
  return data;
}

@end
