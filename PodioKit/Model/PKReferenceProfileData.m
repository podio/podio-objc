//
//  POReferenceProfileData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/1/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKReferenceProfileData.h"


static NSString * const POReferenceProfileDataProfileId = @"ProfileId";
static NSString * const POReferenceProfileDataUserId = @"UserId";
static NSString * const POReferenceProfileDataName = @"Name";
static NSString * const POReferenceProfileDataType = @"Type";
static NSString * const POReferenceProfileDataAvatarId = @"AvatarId";

@implementation PKReferenceProfileData


@synthesize profileId = profileId_;
@synthesize userId = userId_;
@synthesize name = name_;
@synthesize type = type_;
@synthesize avatarId = avatarId_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    profileId_ = [aDecoder decodeIntForKey:POReferenceProfileDataProfileId];
    userId_ = [aDecoder decodeIntForKey:POReferenceProfileDataUserId];
    name_ = [[aDecoder decodeObjectForKey:POReferenceProfileDataName] copy];
    type_ = [aDecoder decodeIntForKey:POReferenceProfileDataType];
    avatarId_ = [aDecoder decodeIntForKey:POReferenceProfileDataAvatarId];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:profileId_ forKey:POReferenceProfileDataProfileId];
  [aCoder encodeInteger:userId_ forKey:POReferenceProfileDataUserId];
  [aCoder encodeObject:name_ forKey:POReferenceProfileDataName];
  [aCoder encodeInteger:type_ forKey:POReferenceProfileDataType];
  [aCoder encodeInteger:avatarId_ forKey:POReferenceProfileDataAvatarId];
}

- (void)dealloc {
  [name_ release];
  [super dealloc];
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
