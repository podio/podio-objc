//
//  PKTNotificationContext.m
//  PodioKit
//
//  Created by Romain Briche on 20/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKTNotificationContext.h"
#import "PKTReference.h"
#import "PKTWorkspace.h"
#import "PKTOrganization.h"
#import "NSValueTransformer+PKTTransformers.h"
#import "NSDictionary+PKTAdditions.h"

@implementation PKTNotificationContext

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"reference": @"ref",
    @"commentCount": @"comment_count"
  };
}

#pragma mark - Properties

- (id)data {
  return self.reference.referenceObject;
}

+ (NSSet *)keyPathsForValuesAffectingData {
  return [NSSet setWithObject:@"reference.referenceObject"];
}

#pragma mark - Value transformers

+ (NSValueTransformer *)referenceValueTransformerWithDictionary:(NSDictionary *)dict {
  NSDictionary *dataDict = [dict pkt_nonNullObjectForKey:@"data"];
  
  return [NSValueTransformer pkt_transformerWithBlock:^id(NSDictionary *objDict) {
    NSMutableDictionary *refDict = [NSMutableDictionary dictionaryWithDictionary:objDict];
    if (dataDict) {
      refDict[@"data"] = dataDict;
    }
    
    return [[PKTReference alloc] initWithDictionary:[refDict copy]];
  }];
}

+ (NSValueTransformer *)rightsValueTransformer {
  return [NSValueTransformer pkt_rightValueTransformer];
}

+ (NSValueTransformer *)linkValueTransformer {
  return [NSValueTransformer pkt_URLTransformer];
}

+ (NSValueTransformer *)spaceValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTWorkspace class]];
}

+ (NSValueTransformer *)orgValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTOrganization class]];
}

@end
