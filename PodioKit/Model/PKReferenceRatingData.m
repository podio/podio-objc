//
//  PKReferenceRatingData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/21/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKReferenceRatingData.h"

static NSString * const PKReferenceRatingDataRatingId = @"RatingId";
static NSString * const PKReferenceRatingDataType = @"Type";
static NSString * const PKReferenceRatingDataValue = @"Value";

@implementation PKReferenceRatingData

@synthesize ratingId = ratingId_;
@synthesize type = type_;
@synthesize value = value_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    ratingId_ = [aDecoder decodeIntegerForKey:PKReferenceRatingDataRatingId];
    type_ = [aDecoder decodeIntegerForKey:PKReferenceRatingDataType];
    value_ = [[aDecoder decodeObjectForKey:PKReferenceRatingDataValue] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:ratingId_ forKey:PKReferenceRatingDataRatingId];
  [aCoder encodeInteger:type_ forKey:PKReferenceRatingDataType];
  [aCoder encodeObject:value_ forKey:PKReferenceRatingDataValue];
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
