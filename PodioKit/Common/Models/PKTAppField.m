//
//  PKTAppField.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTAppField.h"
#import "PKTCategoryOption.h"
#import "NSValueTransformer+PKTTransformers.h"
#import "NSArray+PKTAdditions.h"

@implementation PKTAppField

- (instancetype)initWithFieldID:(NSUInteger)fieldID externalID:(NSString *)externalID type:(PKTAppFieldType)type config:(PKTAppFieldConfig *)config {
  self = [super init];
  if (!self) return nil;
  
  _fieldID = fieldID;
  _externalID = [externalID copy];
  _type = type;
  _config = config;
  
  return self;
}

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"fieldID" : @"field_id",
           @"externalID" : @"external_id",
           @"type" : @"type"
           };
}

+ (NSValueTransformer *)typeValueTransformer {
  return [NSValueTransformer pkt_appFieldTypeTransformer];
}

+ (NSValueTransformer *)configValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTAppFieldConfig class]];
}

#pragma mark - Public

- (PKTCategoryOption *)categoryOptionWithID:(NSUInteger)optionID {
  if (self.type != PKTAppFieldTypeCategory) {
    return nil;
  }

  PKTCategoryOption *option = nil;

  NSDictionary *optionDict = [self.config.settings[@"options"] pkt_firstObjectPassingTest:^BOOL(NSDictionary *dict) {
      return [dict[@"id"] unsignedIntegerValue] == optionID;
  }];

  if (optionDict) {
    option = [[PKTCategoryOption alloc] initWithDictionary:optionDict];
  }

  return option;
}

@end
