//
//  PKQuestionData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
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
@property (nonatomic, strong) NSArray *options;
@property (nonatomic) NSInteger answerCount;
@property (nonatomic, strong) NSMutableDictionary *answerUsers;
@property (nonatomic, strong) NSMutableDictionary *userAnswers;
@property (nonatomic, strong) NSMutableDictionary *answerCounts;

@end
