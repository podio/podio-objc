//
//  PKShareCategoryData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/13/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKShareCategoryData.h"

static NSString * const PKShareCategoryDataCategoryId = @"CategoryId";
static NSString * const PKShareCategoryDataName = @"Name";

@implementation PKShareCategoryData

@synthesize categoryId = categoryId_;
@synthesize name = name_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    categoryId_ = [aDecoder decodeIntegerForKey:PKShareCategoryDataCategoryId];
    name_ = [[aDecoder decodeObjectForKey:PKShareCategoryDataName] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:categoryId_ forKey:PKShareCategoryDataCategoryId];
  [aCoder encodeObject:name_ forKey:PKShareCategoryDataName];

}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  if (dict == nil) return nil;
  
  PKShareCategoryData *data = [self data];
  
  data.categoryId = [[dict pk_objectForKey:@"category_id"] integerValue];
  data.name = [dict pk_objectForKey:@"name"];
  
  return data;
}

@end
