//
//  PKTAppField.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTAppField.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTAppField

- (instancetype)initWithFieldID:(NSUInteger)fieldID externalID:(NSString *)externalID type:(PKTAppFieldType)type {
  self = [super init];
  if (!self) return nil;
  
  _fieldID = fieldID;
  _externalID = [externalID copy];
  _type = type;
  
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

@end
