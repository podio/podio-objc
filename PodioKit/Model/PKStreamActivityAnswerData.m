//
//  PKStreamActivityAnswerData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKStreamActivityAnswerData.h"


static NSString * const PKStreamActivityAnswerDataOptionId = @"OptionId";
static NSString * const PKStreamActivityAnswerDataText = @"Text";

@implementation PKStreamActivityAnswerData

@synthesize optionId = optionId_;
@synthesize text = text_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    optionId_ = [aDecoder decodeIntegerForKey:PKStreamActivityAnswerDataOptionId];
    text_ = [[aDecoder decodeObjectForKey:PKStreamActivityAnswerDataText] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:optionId_ forKey:PKStreamActivityAnswerDataOptionId];
  [aCoder encodeObject:text_ forKey:PKStreamActivityAnswerDataText];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKStreamActivityAnswerData *data = [self data];
  
  NSDictionary *optionDict = [dict pk_objectForKey:@"question_option"];
  data.optionId = [[optionDict pk_objectForKey:@"question_option_id"] unsignedIntegerValue];
  data.text = [optionDict pk_objectForKey:@"text"];
  
  return data;
}

@end
