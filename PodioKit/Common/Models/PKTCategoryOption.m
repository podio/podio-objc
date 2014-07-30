//
//  PKTCategoryOption 
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/05/14
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//


#import "PKTCategoryOption.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTCategoryOption

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"optionID" : @"id",
  };
}

+ (NSValueTransformer *)statusValueTransformer {
  return [NSValueTransformer pkt_transformerWithDictionary:@{
      @"active" : @(PKTCategoryOptionStatusActive),
      @"status" : @(PKTCategoryOptionStatusDeleted)
  }];
}

#pragma mark - NSObject

- (NSUInteger)hash {
  return [@(self.optionID) hash];
}

- (BOOL)isEqual:(id)object {
  if (![object isKindOfClass:[self class]]) return NO;
  
  PKTCategoryOption *option = object;
  
  return option.optionID == self.optionID;
}

@end