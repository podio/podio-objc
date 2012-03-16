//
//  PKQuestionOptionData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKQuestionOptionData.h"

static NSString * const PKQuestionOptionDataOptionId = @"OptionId";
static NSString * const PKQuestionOptionDataText = @"Text";

@implementation PKQuestionOptionData

@synthesize optionId = optionId_;
@synthesize text = text_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    optionId_ = [aDecoder decodeIntegerForKey:PKQuestionOptionDataOptionId];
    text_ = [[aDecoder decodeObjectForKey:PKQuestionOptionDataText] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:optionId_ forKey:PKQuestionOptionDataOptionId];
  [aCoder encodeObject:text_ forKey:PKQuestionOptionDataText];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKQuestionOptionData *data = [self data];
  data.optionId = [[dict pk_objectForKey:@"question_option_id"] unsignedIntegerValue];
  data.text = [dict pk_objectForKey:@"text"];
  
  return data;
}

@end
