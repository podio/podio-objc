//
//  PKProviderData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/1/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKProviderData.h"

static NSString * const PKProviderDataNameKey = @"Name";
static NSString * const PKProviderDataHumanizedNameKey = @"HumanizedName";
static NSString * const PKProviderDataConnectLinkKey = @"ConnectLink";

@implementation PKProviderData

@synthesize name = name_;
@synthesize humanizedName = humanizedName_;
@synthesize connectLink = connectLink_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    name_ = [[aDecoder decodeObjectForKey:PKProviderDataNameKey] copy];
    humanizedName_ = [[aDecoder decodeObjectForKey:PKProviderDataHumanizedNameKey] copy];
    connectLink_ = [[aDecoder decodeObjectForKey:PKProviderDataConnectLinkKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:name_ forKey:PKProviderDataNameKey];
  [aCoder encodeObject:humanizedName_ forKey:PKProviderDataHumanizedNameKey];
  [aCoder encodeObject:connectLink_ forKey:PKProviderDataConnectLinkKey];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKProviderData *data = [self data];
  
  data.name = [dict pk_objectForKey:@"name"];
  data.humanizedName = [dict pk_objectForKey:@"humanized_name"];
  data.connectLink = [dict pk_objectForKey:@"connect_link"];
  
  return data;
}

@end
