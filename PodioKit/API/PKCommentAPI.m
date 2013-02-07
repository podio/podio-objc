//
//  PKCommentAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/28/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKCommentAPI.h"

@implementation PKCommentAPI

+ (PKRequest *)requestForPostCommentWithText:(NSString *)text referenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType {
  return [self requestForPostCommentWithText:text referenceId:referenceId referenceType:referenceType fileIds:nil];
}

+ (PKRequest *)requestForPostCommentWithText:(NSString *)text referenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType fileIds:(NSArray *)fileIds {
	NSString * uri = [NSString stringWithFormat:@"/comment/%@/%d/", [PKConstants stringForReferenceType:referenceType], referenceId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodPOST objectMapping:nil];
  
	request.body = [[NSMutableDictionary alloc] init];
  request.body[@"value"] = text;
  
  if ([fileIds count] > 0) {
    request.body[@"file_ids"] = fileIds;
  }
  
  return request;
}

@end
