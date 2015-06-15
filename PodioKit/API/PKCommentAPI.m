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
  return [self requestForPostCommentWithText:text referenceId:referenceId referenceType:referenceType fileIds:nil alertInvite:NO];
}

+ (PKRequest *)requestForPostCommentWithText:(NSString *)text referenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType fileIds:(NSArray *)fileIds alertInvite:(BOOL)alertInvite {
	NSString *uri = [NSString stringWithFormat:@"/comment/%@/%ld/", [PKConstants stringForReferenceType:referenceType], (unsigned long)referenceId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodPOST objectMapping:nil];
  
  request.parameters[@"alert_invite"] = @(alertInvite);
  
	request.body = [[NSMutableDictionary alloc] init];
  request.body[@"value"] = text;
  
  if ([fileIds count] > 0) {
    request.body[@"file_ids"] = fileIds;
  }
  
  return request;
}

+ (PKRequest *)requestToDeleteCommentWithId:(NSUInteger)commentId {
  NSString *uri = [NSString stringWithFormat:@"/comment/%ld", (unsigned long)commentId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodDELETE objectMapping:nil];
  
  return request;
}

@end
