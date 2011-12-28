//
//  POReferenceSpaceData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/21/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKReferenceSpaceData.h"


static NSString * const POReferenceSpaceDataSpaceId = @"SpaceId";
static NSString * const POReferenceSpaceDataType = @"Type";
static NSString * const POReferenceSpaceDataName = @"Name";

@implementation PKReferenceSpaceData

@synthesize spaceId = spaceId_;
@synthesize type = type_;
@synthesize name = name_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    spaceId_ = [aDecoder decodeIntForKey:POReferenceSpaceDataSpaceId];
    type_ = [aDecoder decodeIntForKey:POReferenceSpaceDataType];
    name_ = [[aDecoder decodeObjectForKey:POReferenceSpaceDataName] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:spaceId_ forKey:POReferenceSpaceDataSpaceId];
  [aCoder encodeInteger:type_ forKey:POReferenceSpaceDataType];
  [aCoder encodeObject:name_ forKey:POReferenceSpaceDataName];
}

- (void)dealloc {
  [name_ release];
  [super dealloc];
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
