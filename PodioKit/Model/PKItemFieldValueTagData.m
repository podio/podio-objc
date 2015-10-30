//
//  PKItemFieldValueTagData.m
//  PodioKit
//
//  Created by Pavel Prochazka on 30/10/15.
//  Copyright © 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKItemFieldValueTagData.h"

static NSString * const PKItemFieldValueTagsDataTagKey = @"Tags";

@implementation PKItemFieldValueTagData

@synthesize tags = tags_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    tags_ = [[aDecoder decodeObjectForKey:PKItemFieldValueTagsDataTagKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:tags_ forKey:PKItemFieldValueTagsDataTagKey];
}

- (NSDictionary *)valueDictionary {
  return @{@"values": [self.tags pk_arrayFromObjectsCollectedWithBlock:^id(NSString *value) {
    return @{@"value": value};
  }]};
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemFieldValueTagData *data = [self data];
  
  data.tags = [[dict pk_objectForKey:@"values"] pk_arrayFromObjectsCollectedWithBlock:^id(NSDictionary *value) {
    return value[@"value"];
  }];
  
  return data;
}

@end
