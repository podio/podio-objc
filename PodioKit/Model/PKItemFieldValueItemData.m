//
//  PKItemFieldValueItemData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-07.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKItemFieldValueItemData.h"


static NSString * const PKItemFieldValueItemDataItemIdKey = @"ItemId";
static NSString * const PKItemFieldValueItemDataTitleKey = @"Title";
static NSString * const PKItemFieldValueItemDataAppIdKey = @"AppId";
static NSString * const PKItemFieldValueItemDataAppNameKey = @"AppName";
static NSString * const PKItemFieldValueItemDataAppIconKey = @"AppIcon";

@implementation PKItemFieldValueItemData

@synthesize itemId = itemId_;
@synthesize title = title_;
@synthesize appId = appId_;
@synthesize appName = appName_;
@synthesize appIcon = appIcon_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    itemId_ = [aDecoder decodeIntegerForKey:PKItemFieldValueItemDataItemIdKey];
    title_ = [[aDecoder decodeObjectForKey:PKItemFieldValueItemDataTitleKey] copy];
    appId_ = [aDecoder decodeIntegerForKey:PKItemFieldValueItemDataAppIdKey];
    appName_ = [[aDecoder decodeObjectForKey:PKItemFieldValueItemDataAppNameKey] copy];
    appIcon_ = [[aDecoder decodeObjectForKey:PKItemFieldValueItemDataAppIconKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:itemId_ forKey:PKItemFieldValueItemDataItemIdKey];
  [aCoder encodeObject:title_ forKey:PKItemFieldValueItemDataTitleKey];
  [aCoder encodeInteger:appId_ forKey:PKItemFieldValueItemDataAppIdKey];
  [aCoder encodeObject:appName_ forKey:PKItemFieldValueItemDataAppNameKey];
  [aCoder encodeObject:appIcon_ forKey:PKItemFieldValueItemDataAppIconKey];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemFieldValueItemData *data = [self data];
  
  NSDictionary *refDict = [dict pk_objectForKey:@"value"];
  
  data.itemId = [[refDict pk_objectForKey:@"item_id"] integerValue];
  data.title = [refDict pk_objectForKey:@"title"];
  data.appId = [[[refDict pk_objectForKey:@"app"] pk_objectForKey:@"app_id"] integerValue];
  data.appIcon = [[refDict pk_objectForKey:@"app"] pk_objectForKey:@"icon"];
  data.appName = [[refDict pk_objectForKey:@"app"] pk_objectForKey:@"name"];
  
  return data;
}

@end
