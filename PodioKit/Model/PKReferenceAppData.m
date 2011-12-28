//
//  POReferenceAppData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/1/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKReferenceAppData.h"

static NSString * const POReferenceAppDataAppId = @"AppId";
static NSString * const POReferenceAppDataName = @"Name";
static NSString * const POReferenceAppDataIcon = @"Icon";

@implementation PKReferenceAppData

@synthesize appId = appId_;
@synthesize name = name_;
@synthesize icon = icon_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    appId_ = [aDecoder decodeIntForKey:POReferenceAppDataAppId];
    name_ = [[aDecoder decodeObjectForKey:POReferenceAppDataName] copy];
    icon_ = [[aDecoder decodeObjectForKey:POReferenceAppDataIcon] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:appId_ forKey:POReferenceAppDataAppId];
  [aCoder encodeObject:name_ forKey:POReferenceAppDataName];
  [aCoder encodeObject:icon_ forKey:POReferenceAppDataIcon];
}

- (void)dealloc {
  [icon_ release];
  [name_ release];
  [super dealloc];
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
