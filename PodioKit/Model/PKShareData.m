//
//  PKShareData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/13/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKShareData.h"

static NSString * const PKShareDataAppId = @"AppId";
static NSString * const PKShareDataName = @"Name";
static NSString * const PKShareDataAbstract = @"Abstract";
static NSString * const PKShareDataIcon = @"Icon";
static NSString * const PKShareDataRating = @"Rating";

@implementation PKShareData

@synthesize appId = appId_;
@synthesize name = name_;
@synthesize abstract = abstract_;
@synthesize icon = icon_;
@synthesize rating = rating_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    appId_ = [aDecoder decodeIntegerForKey:PKShareDataAppId];
    name_ = [[aDecoder decodeObjectForKey:PKShareDataName] copy];
    abstract_ = [[aDecoder decodeObjectForKey:PKShareDataAbstract] copy];
    icon_ = [[aDecoder decodeObjectForKey:PKShareDataIcon] copy];
    rating_ = [aDecoder decodeIntegerForKey:PKShareDataRating];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:appId_ forKey:PKShareDataAppId];
  [aCoder encodeObject:name_ forKey:PKShareDataName];
  [aCoder encodeObject:abstract_ forKey:PKShareDataAbstract];
  [aCoder encodeObject:icon_ forKey:PKShareDataIcon];
  [aCoder encodeInteger:rating_ forKey:PKShareDataRating];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  if (dict == nil) return nil;
  
  PKShareData *data = [self data];
  
  data.appId = [[dict pk_objectForKey:@"app_id"] integerValue];
  data.name = [dict pk_objectForKey:@"name"];
  data.abstract = [dict pk_objectForKey:@"abstract"];
  data.icon = [dict pk_objectForKey:@"icon"];
  data.rating = [[dict pk_objectForKey:@"rating"] integerValue];
  
  return data;
}

@end
