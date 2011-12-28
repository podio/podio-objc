//
//  POStreamActivityAnswerData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKStreamActivityAnswerData.h"


static NSString * const POStreamActivityAnswerDataOptionId = @"OptionId";
static NSString * const POStreamActivityAnswerDataText = @"Text";

@implementation PKStreamActivityAnswerData

@synthesize optionId = optionId_;
@synthesize text = text_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    optionId_ = [aDecoder decodeIntegerForKey:POStreamActivityAnswerDataOptionId];
    text_ = [[aDecoder decodeObjectForKey:POStreamActivityAnswerDataText] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:optionId_ forKey:POStreamActivityAnswerDataOptionId];
  [aCoder encodeObject:text_ forKey:POStreamActivityAnswerDataText];
}

- (void)dealloc {
  [text_ release];
  [super dealloc];
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
