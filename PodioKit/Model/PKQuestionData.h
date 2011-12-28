//
//  POQuestionData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKObjectData.h"

@interface PKQuestionData : PKObjectData {

 @private
  NSInteger questionId_;
  NSString *text_;
  NSArray *options_;
  NSInteger answerCount_;
  
  NSMutableDictionary *answerUsers_;
  NSMutableDictionary *userAnswers_;
  NSMutableDictionary *answerCounts_;
}

@property (nonatomic) NSInteger questionId;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, retain) NSArray *options;
@property (nonatomic) NSInteger answerCount;
@property (nonatomic, retain) NSMutableDictionary *answerUsers;
@property (nonatomic, retain) NSMutableDictionary *userAnswers;
@property (nonatomic, retain) NSMutableDictionary *answerCounts;

- (void)updateAnswerWithOptionId:(NSUInteger)optionId forUserWithId:(NSUInteger)userId;

@end
