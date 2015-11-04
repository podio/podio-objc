//
//  PKItemFieldValueTagData.m
//  PodioKit
//
//  Created by Pavel Prochazka on 30/10/15.
//  Copyright © 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKItemFieldValueTagData.h"

static NSString * const PKItemFieldValueTagDataTagKey = @"Tag";

@implementation PKItemFieldValueTagData

@synthesize tag = tag_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    tag_ = [[aDecoder decodeObjectForKey:PKItemFieldValueTagDataTagKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:tag_ forKey:PKItemFieldValueTagDataTagKey];
}

- (NSDictionary *)valueDictionary {
  return @{@"value": self.tag};
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dictionary {
  NSString *tagString = [dictionary pk_objectForKey:@"value"];
  return [PKItemFieldValueTagData dataFromTagString:tagString];
}

+ (id)dataFromTagString:(NSString *)tagString {
  PKItemFieldValueTagData *data = [self data];
  data.tag = tagString;
  
  return data;
}

@end