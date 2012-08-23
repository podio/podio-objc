//
//  PKReferenceAnswerData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKReferenceAnswerData.h"


static NSString * const PKReferenceAnswerDataOptionId = @"OptionId";
static NSString * const PKReferenceAnswerDataText = @"Text";

@implementation PKReferenceAnswerData

@synthesize optionId = optionId_;
@synthesize text = text_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    optionId_ = [aDecoder decodeIntegerForKey:PKReferenceAnswerDataOptionId];
    text_ = [[aDecoder decodeObjectForKey:PKReferenceAnswerDataText] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:optionId_ forKey:PKReferenceAnswerDataOptionId];
  [aCoder encodeObject:text_ forKey:PKReferenceAnswerDataText];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceAnswerData *data = [self data];
  
  NSDictionary *optionDict = [dict pk_objectForKey:@"question_option"];
  data.optionId = [[optionDict pk_objectForKey:@"question_option_id"] unsignedIntegerValue];
  data.text = [optionDict pk_objectForKey:@"text"];
  
  return data;
}

@end
