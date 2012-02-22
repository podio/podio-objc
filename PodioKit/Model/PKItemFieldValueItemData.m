//
//  POTransformableAppItemData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-07.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKItemFieldValueItemData.h"


static NSString * const POTransformableAppItemDataItemIdKey = @"ItemId";
static NSString * const POTransformableAppItemDataTitleKey = @"Title";
static NSString * const POTransformableAppItemDataAppIdKey = @"AppId";
static NSString * const POTransformableAppItemDataAppNameKey = @"AppName";
static NSString * const POTransformableAppItemDataAppIconKey = @"AppIcon";

@implementation PKItemFieldValueItemData

@synthesize itemId = itemId_;
@synthesize title = title_;
@synthesize appId = appId_;
@synthesize appName = appName_;
@synthesize appIcon = appIcon_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    itemId_ = [aDecoder decodeIntegerForKey:POTransformableAppItemDataItemIdKey];
    title_ = [[aDecoder decodeObjectForKey:POTransformableAppItemDataTitleKey] copy];
    appId_ = [aDecoder decodeIntegerForKey:POTransformableAppItemDataAppIdKey];
    appName_ = [[aDecoder decodeObjectForKey:POTransformableAppItemDataAppNameKey] copy];
    appIcon_ = [[aDecoder decodeObjectForKey:POTransformableAppItemDataAppIconKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:itemId_ forKey:POTransformableAppItemDataItemIdKey];
  [aCoder encodeObject:title_ forKey:POTransformableAppItemDataTitleKey];
  [aCoder encodeInteger:appId_ forKey:POTransformableAppItemDataAppIdKey];
  [aCoder encodeObject:appName_ forKey:POTransformableAppItemDataAppNameKey];
  [aCoder encodeObject:appIcon_ forKey:POTransformableAppItemDataAppIconKey];
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
