//
//  PKReferenceSpaceData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/21/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKReferenceSpaceData.h"


static NSString * const PKReferenceSpaceDataSpaceId = @"SpaceId";
static NSString * const PKReferenceSpaceDataType = @"Type";
static NSString * const PKReferenceSpaceDataName = @"Name";

@implementation PKReferenceSpaceData

@synthesize spaceId = spaceId_;
@synthesize type = type_;
@synthesize name = name_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    spaceId_ = [aDecoder decodeIntForKey:PKReferenceSpaceDataSpaceId];
    type_ = [aDecoder decodeIntForKey:PKReferenceSpaceDataType];
    name_ = [[aDecoder decodeObjectForKey:PKReferenceSpaceDataName] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:spaceId_ forKey:PKReferenceSpaceDataSpaceId];
  [aCoder encodeInteger:type_ forKey:PKReferenceSpaceDataType];
  [aCoder encodeObject:name_ forKey:PKReferenceSpaceDataName];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceSpaceData *data = [self data];
  
  data.spaceId = [[dict pk_objectForKey:@"space_id"] integerValue];
  data.type = [[dict pk_objectForKey:@"type"] isEqualToString:kPKSpaceTypeEmployeeNetwork] ? 
    PKSpaceTypeEmployeeNetwork : PKSpaceTypeRegular;
  data.name = [dict pk_objectForKey:@"name"];
  
  return data;
}

@end
