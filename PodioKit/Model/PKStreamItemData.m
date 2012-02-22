//
//  POStreamItemData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKStreamItemData.h"


static NSString * const POStreamItemDataItemId = @"ItemId";
static NSString * const POStreamItemDataTitle = @"Title";

@implementation PKStreamItemData

@synthesize itemId = itemId_;
@synthesize title = title_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    itemId_ = [aDecoder decodeIntegerForKey:POStreamItemDataItemId];
    title_ = [[aDecoder decodeObjectForKey:POStreamItemDataTitle] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:itemId_ forKey:POStreamItemDataItemId];
  [aCoder encodeObject:title_ forKey:POStreamItemDataTitle];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKStreamItemData *data = [self data];
  data.itemId = [[dict pk_objectForKey:@"item_id"] integerValue];
  data.title = [dict pk_objectForKey:@"title"];
  
  return data;
}

@end
