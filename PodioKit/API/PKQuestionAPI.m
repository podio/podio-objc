//
//  PKQuestionAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/28/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKQuestionAPI.h"

@implementation PKQuestionAPI

+ (PKRequest *)requestToAnswerQuestionWithId:(NSUInteger)questionId withOptionId:(NSUInteger)optionId referenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType {
	NSString * uri = [NSString stringWithFormat:@"/question/%d/%@/%d/", questionId, [PKConstants stringForReferenceType:referenceType], referenceId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKAPIRequestMethodPOST];
	request.body = @{@"question_option_id": @(optionId)};
  
  return request;
}

@end
