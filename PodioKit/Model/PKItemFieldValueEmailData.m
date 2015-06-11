//
//  PKItemFieldValueEmailData.m
//  PodioKit
//
//  Created by Pavel Prochazka on 08/06/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKItemFieldValueEmailData.h"

static NSString * const PKItemFieldValueEmailDataEmailKey = @"Email";
static NSString * const PKItemFieldValueEmailDataTypeKey  = @"EmailType";

@implementation PKItemFieldValueEmailData

@synthesize email = email_;
@synthesize type = type_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    email_ = [[aDecoder decodeObjectForKey:PKItemFieldValueEmailDataEmailKey] copy];
    type_ =  [aDecoder decodeIntegerForKey:PKItemFieldValueEmailDataTypeKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:email_ forKey:PKItemFieldValueEmailDataEmailKey];
  [aCoder encodeInteger:type_ forKey:PKItemFieldValueEmailDataTypeKey];
}

- (NSDictionary *)valueDictionary {
  NSString *type;
  switch (self.type) {
    case PKEmailTypeHome:
      type = @"home";
      break;
    case PKEmailTypeWork:
      type = @"work";
      break;
    case PKEmailTypeOther:
      type = @"other";
      break;
  }
  
  return @{@"value": self.email,
           @"type": type};
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemFieldValueEmailData *data = [self data];
  
  data.email = [dict pk_objectForKey:@"value"];
  
  NSString *type = [dict pk_objectForKey:@"type"];
  if ([type isEqualToString:@"home"]) {
    data.type = PKEmailTypeHome;
  }
  else if ([type isEqualToString:@"work"]){
    data.type = PKEmailTypeWork;
  }
  else if ([type isEqualToString:@"other"]){
    data.type = PKEmailTypeOther;
  }
  
  return data;
}


@end
