//
//  PKByLineData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/7/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKByLineData.h"


static NSString * const PKByLineDataId = @"Id";
static NSString * const PKByLineDataType = @"Type";
static NSString * const PKByLineDataName = @"Name";
static NSString * const PKByLineDataAvatarType = @"AvatarType";
static NSString * const PKByLineDataAvatarId = @"AvatarId";
static NSString * const PKByLineDataAvatarImage = @"AvatarImage";

@implementation PKByLineData

@synthesize byId = byId_;
@synthesize type = type_;
@synthesize name = name_;
@synthesize avatarType = avatarType_;
@synthesize avatarId = avatarId_;
@synthesize avatarImage = avatarImage_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    byId_ = [aDecoder decodeIntegerForKey:PKByLineDataId];
    type_ = [[aDecoder decodeObjectForKey:PKByLineDataType] copy];
    name_ = [[aDecoder decodeObjectForKey:PKByLineDataName] copy];
    avatarType_ = [aDecoder decodeIntegerForKey:PKByLineDataAvatarType];
    avatarId_ = [aDecoder decodeIntegerForKey:PKByLineDataAvatarId];
    avatarImage_ = [aDecoder decodeObjectForKey:PKByLineDataAvatarImage];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:byId_ forKey:PKByLineDataId];
  [aCoder encodeObject:type_ forKey:PKByLineDataType];
  [aCoder encodeObject:name_ forKey:PKByLineDataName];
  [aCoder encodeInteger:avatarType_ forKey:PKByLineDataAvatarType];
  [aCoder encodeInteger:avatarId_ forKey:PKByLineDataAvatarId];
  [aCoder encodeObject:avatarImage_ forKey:PKByLineDataAvatarImage];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  if (dict == nil) return nil;
  
  PKByLineData *data = [self data];
  
  data.byId = [[dict pk_objectForKey:@"id"] integerValue];
  data.type = [dict pk_objectForKey:@"type"];
  data.name = [dict pk_objectForKey:@"name"];
  data.avatarType = [PKConstants avatarTypeForString:[dict pk_objectForKey:@"avatar_type"]];
  data.avatarId = [[dict pk_objectForKey:@"avatar_id"] integerValue];
  data.avatarImage = [PKFileData dataFromDictionary:[dict pk_objectForKey:@"image"]];
  
  return data;
}

@end
