//
//  PKProviderData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/1/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKProviderData.h"

static NSString * const PKProviderDataNameKey = @"Name";
static NSString * const PKProviderDataURLKey = @"URL";

@implementation PKProviderData

@synthesize name = name_;
@synthesize url = url_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    name_ = [[aDecoder decodeObjectForKey:PKProviderDataNameKey] copy];
    url_ = [[aDecoder decodeObjectForKey:PKProviderDataURLKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:name_ forKey:PKProviderDataNameKey];
  [aCoder encodeObject:url_ forKey:PKProviderDataURLKey];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKProviderData *data = [self data];
  
  data.name = [dict pk_objectForKey:@"name"];
  data.url = [dict pk_objectForKey:@"url"];
  
  return data;
}

@end
