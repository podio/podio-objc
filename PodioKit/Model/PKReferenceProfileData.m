//
//  PKReferenceProfileData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/1/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKReferenceProfileData.h"
#import "PKFileData.h"

static NSString * const PKReferenceProfileDataProfileId = @"ProfileId";
static NSString * const PKReferenceProfileDataUserId = @"UserId";
static NSString * const PKReferenceProfileDataName = @"Name";
static NSString * const PKReferenceProfileDataType = @"Type";
static NSString * const PKReferenceProfileDataAvatarId = @"AvatarId";
static NSString * const PKReferenceProfileDataImage = @"Image";
static NSString * const PKReferenceProfileDataRemovable = @"Removable";

@implementation PKReferenceProfileData

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _profileId = [aDecoder decodeIntForKey:PKReferenceProfileDataProfileId];
    _userId = [aDecoder decodeIntForKey:PKReferenceProfileDataUserId];
    _name = [[aDecoder decodeObjectForKey:PKReferenceProfileDataName] copy];
    _type = [aDecoder decodeIntForKey:PKReferenceProfileDataType];
    _avatarId = [aDecoder decodeIntForKey:PKReferenceProfileDataAvatarId];
    _image = [aDecoder decodeObjectOfClass:[PKFileData class] forKey:PKReferenceProfileDataImage];
    _removable = [aDecoder decodeBoolForKey:PKReferenceProfileDataRemovable];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:_profileId forKey:PKReferenceProfileDataProfileId];
  [aCoder encodeInteger:_userId forKey:PKReferenceProfileDataUserId];
  [aCoder encodeObject:_name forKey:PKReferenceProfileDataName];
  [aCoder encodeInteger:_type forKey:PKReferenceProfileDataType];
  [aCoder encodeInteger:_avatarId forKey:PKReferenceProfileDataAvatarId];
  [aCoder encodeObject:_image forKey:PKReferenceProfileDataImage];
  [aCoder encodeBool:_removable forKey:PKReferenceProfileDataRemovable];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceProfileData *data = [self data];
  
  data.profileId = [[dict pk_objectForKey:@"profile_id"] integerValue];
  data.userId = [[dict pk_objectForKey:@"user_id"] integerValue];
  data.name = [dict pk_objectForKey:@"name"];
  data.type = [PKConstants referenceTypeForString:[dict pk_objectForKey:@"type"]];
  data.avatarId = [[dict pk_objectForKey:@"avatar"] integerValue];
  data.image = [PKFileData dataFromDictionary:[dict pk_objectForKey:@"image"]];
  data.removable = [[dict pk_objectForKey:@"removable"] boolValue];
  
  return data;
}

@end
