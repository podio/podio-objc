//
//  POQuestionData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKQuestionData.h"
#import "PKQuestionOptionData.h"

static NSString * const POQuestionDataQuestionId = @"QuestionId";
static NSString * const POQuestionDataText = @"Text";
static NSString * const POQuestionDataOptions = @"Options";
static NSString * const POQuestionDataAnswerCount = @"AnswerCount";
static NSString * const POQuestionDataAnswerUsers = @"AnswerUsers";
static NSString * const POQuestionDataUserAnswers = @"UserAnswers";
static NSString * const POQuestionDataAnswerCounts = @"AnswerCounts";

@implementation PKQuestionData

@synthesize questionId = questionId_;
@synthesize text = text_;
@synthesize options = options_;
@synthesize answerCount = answerCount_;
@synthesize answerUsers = answerUsers_;
@synthesize userAnswers = userAnswers_;
@synthesize answerCounts = answerCounts_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    questionId_ = [aDecoder decodeIntegerForKey:POQuestionDataQuestionId];
    text_ = [[aDecoder decodeObjectForKey:POQuestionDataText] copy];
    options_ = [aDecoder decodeObjectForKey:POQuestionDataOptions];
    answerCount_ = [aDecoder decodeIntegerForKey:POQuestionDataAnswerCount];
    answerUsers_ = [aDecoder decodeObjectForKey:POQuestionDataAnswerUsers];
    userAnswers_ = [aDecoder decodeObjectForKey:POQuestionDataUserAnswers];
    answerCounts_ = [aDecoder decodeObjectForKey:POQuestionDataAnswerCounts];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:questionId_ forKey:POQuestionDataQuestionId];
  [aCoder encodeObject:text_ forKey:POQuestionDataText];
  [aCoder encodeObject:options_ forKey:POQuestionDataOptions];
  [aCoder encodeInteger:answerCount_ forKey:POQuestionDataAnswerCount];
  [aCoder encodeObject:answerUsers_ forKey:POQuestionDataAnswerUsers];
  [aCoder encodeObject:userAnswers_ forKey:POQuestionDataUserAnswers];
  [aCoder encodeObject:answerCounts_ forKey:POQuestionDataAnswerCounts];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKQuestionData *data = [self data];
  data.questionId = [[dict pk_objectForKey:@"question_id"] integerValue];
  data.text = [dict pk_objectForKey:@"text"];
  data.options = [PKQuestionOptionData dataObjectsFromArray:[dict pk_objectForKey:@"options"]];
  
  NSMutableDictionary *answerUsers = [[NSMutableDictionary alloc] init];
  NSMutableDictionary *userAnswers = [[NSMutableDictionary alloc] init];
  NSMutableDictionary *answerCounts = [[NSMutableDictionary alloc] init];
  
  [[dict pk_objectForKey:@"answers"] enumerateObjectsUsingBlock:^(id answerDict, NSUInteger idx, BOOL *stop) {
    NSNumber *optionId = [answerDict pk_objectForKey:@"question_option_id"];
    NSNumber *userId = [[answerDict pk_objectForKey:@"user"] pk_objectForKey:@"user_id"];
    
    NSMutableArray *votingUsers = [answerUsers objectForKey:optionId];
    if (votingUsers == nil) {
      votingUsers = [NSMutableArray array];
    }

    [votingUsers addObject:userId];
    
    [answerCounts setObject:[NSNumber numberWithInteger:[votingUsers count]] forKey:optionId]; // option id -> count
    [answerUsers setObject:votingUsers forKey:optionId];  // option id -> [users ids]
    [userAnswers setObject:optionId forKey:userId];       // user id -> option id
  }];
  
  data.answerCount = [userAnswers count];
  
  data.answerUsers = answerUsers;
  
  data.userAnswers = userAnswers;
  
  data.answerCounts = answerCounts;
  
  return data;
}

- (void)updateAnswerWithOptionId:(NSUInteger)optionId forUserWithId:(NSUInteger)userId {
  NSNumber *userIdNum = [NSNumber numberWithUnsignedInteger:userId];
  NSNumber *optionIdNum = [NSNumber numberWithUnsignedInteger:optionId];
  NSNumber *currentOptionId = [self.userAnswers objectForKey:userIdNum];
  
  if ([currentOptionId unsignedIntegerValue] == optionId) {
    // Same, do nothing
    return;
  }
  
  // Clear old answer
  if (currentOptionId != nil) {
    // Decrement old option count
    NSUInteger currentCount = [[self.answerCounts objectForKey:currentOptionId] unsignedIntegerValue];
    currentCount--;
    
    if (currentCount > 0) {
      [self.answerCounts setObject:[NSNumber numberWithUnsignedInteger:currentCount] forKey:currentOptionId];
    } else {
      [self.answerCounts removeObjectForKey:currentOptionId];
    }
    
    // Remove from user set
    NSMutableArray *answerUsers = [self.answerUsers objectForKey:currentOptionId];
    [answerUsers removeObject:userIdNum];
    [self.answerUsers setObject:answerUsers forKey:currentOptionId];
    
    // Remove user answer
    [self.userAnswers removeObjectForKey:userIdNum];
  }
  
  // Update with new answer
  NSUInteger currentCount = [[self.answerCounts objectForKey:optionIdNum] unsignedIntegerValue];
  [self.answerCounts setObject:[NSNumber numberWithUnsignedInteger:currentCount + 1] forKey:optionIdNum];
  
  NSMutableArray *answerUsers = [self.answerUsers objectForKey:optionIdNum];
  if (answerUsers == nil) {
    answerUsers = [NSMutableArray array];
  }
  
  [answerUsers addObject:userIdNum];
  [self.answerUsers setObject:answerUsers forKey:optionIdNum];
  
  [self.userAnswers setObject:optionIdNum forKey:userIdNum];
}

@end
