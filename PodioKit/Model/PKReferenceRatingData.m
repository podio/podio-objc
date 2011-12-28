//
//  POStreamActivityRatingData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/21/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKReferenceRatingData.h"

static NSString * const POStreamActivityRatingDataRatingId = @"RatingId";
static NSString * const POStreamActivityRatingDataType = @"Type";
static NSString * const POStreamActivityRatingDataValue = @"Value";

@implementation PKReferenceRatingData

@synthesize ratingId = ratingId_;
@synthesize type = type_;
@synthesize value = value_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    ratingId_ = [aDecoder decodeIntegerForKey:POStreamActivityRatingDataRatingId];
    type_ = [aDecoder decodeIntegerForKey:POStreamActivityRatingDataType];
    value_ = [[aDecoder decodeObjectForKey:POStreamActivityRatingDataValue] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:ratingId_ forKey:POStreamActivityRatingDataRatingId];
  [aCoder encodeInteger:type_ forKey:POStreamActivityRatingDataType];
  [aCoder encodeObject:value_ forKey:POStreamActivityRatingDataValue];
}

- (void)dealloc {
  [value_ release];
  [super dealloc];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceRatingData *data = [self data];
  
  data.ratingId = [[dict pk_objectForKey:@"rating_id"] integerValue];
  data.type = [PKConstants ratingTypeForString:[dict pk_objectForKey:@"type"]];
  data.value = [dict pk_objectForKey:@"value"];
  
  return data;
}

@end
