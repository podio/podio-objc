//
//  PKItemFieldValuePhoneData.m
//  PodioKit
//
//  Created by Pavel Prochazka on 08/06/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKItemFieldValuePhoneData.h"

static NSString * const PKItemFieldValuePhoneDataNumberKey  = @"PhoneNumber";
static NSString * const PKItemFieldValuePhoneDataTypeKey    = @"PhoneType";

@implementation PKItemFieldValuePhoneData

@synthesize number = number_;
@synthesize type = type_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    number_ = [[aDecoder decodeObjectForKey:PKItemFieldValuePhoneDataNumberKey] copy];
    type_ =   [aDecoder decodeIntegerForKey:PKItemFieldValuePhoneDataTypeKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:number_ forKey:PKItemFieldValuePhoneDataNumberKey];
  [aCoder encodeInteger:type_ forKey:PKItemFieldValuePhoneDataTypeKey];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemFieldValuePhoneData *data = [self data];
  
  data.number = [dict pk_objectForKey:@"value"];
  
  NSString *type = [dict pk_objectForKey:@"type"];
  if ([type isEqualToString:@"mobile"]) {
    data.type = PKPhoneTypeMobile;
  }
  else if ([type isEqualToString:@"work"]){
    data.type = PKPhoneTypeWork;
  }
  else if ([type isEqualToString:@"home"]){
    data.type = PKPhoneTypeHome;
  }
  else if ([type isEqualToString:@"main"]){
    data.type = PKPhoneTypeMain;
  }
  else if ([type isEqualToString:@"work_fax"]){
    data.type = PKPhoneTypeWorkFax;
  }
  else if ([type isEqualToString:@"private_fax"]){
    data.type = PKPhoneTypePrivateFax;
  }
  else if ([type isEqualToString:@"other"]){
    data.type = PKPhoneTypeOther;
  }
  
  return data;
}

@end