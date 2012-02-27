//
//  PKReferenceAppData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/1/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKReferenceAppData.h"

static NSString * const PKReferenceAppDataAppId = @"AppId";
static NSString * const PKReferenceAppDataName = @"Name";
static NSString * const PKReferenceAppDataIcon = @"Icon";

@implementation PKReferenceAppData

@synthesize appId = appId_;
@synthesize name = name_;
@synthesize icon = icon_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    appId_ = [aDecoder decodeIntForKey:PKReferenceAppDataAppId];
    name_ = [[aDecoder decodeObjectForKey:PKReferenceAppDataName] copy];
    icon_ = [[aDecoder decodeObjectForKey:PKReferenceAppDataIcon] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:appId_ forKey:PKReferenceAppDataAppId];
  [aCoder encodeObject:name_ forKey:PKReferenceAppDataName];
  [aCoder encodeObject:icon_ forKey:PKReferenceAppDataIcon];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceAppData *data = [self data];
  
  data.appId = [[dict pk_objectForKey:@"app_id"] integerValue];
  data.name = [dict pk_objectForKey:@"name"];
  data.icon = [dict pk_objectForKey:@"icon"];
  
  return data;
}

@end
