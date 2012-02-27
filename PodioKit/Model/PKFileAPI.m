//
//  PKFileAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/21/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKFileAPI.h"

@implementation PKFileAPI

+ (PKFileOperation *)uploadFileWithPath:(NSString *)filePath fileName:(NSString *)fileName completion:(PKRequestCompletionBlock)completion {
  PKAPIClient *apiClient = [[PKRequestManager sharedManager] apiClient];
  PKFileOperation *operation = [PKFileOperation uploadOperationWithURLString:apiClient.fileUploadURLString filePath:filePath fileName:fileName];
  operation.requestCompletionBlock = completion;
  
  [apiClient addFileOperation:operation];
  
  return operation;
}

+ (PKFileOperation *)uploadFileWithImage:(UIImage *)image completion:(PKRequestCompletionBlock)completion {
  PKAPIClient *apiClient = [[PKRequestManager sharedManager] apiClient];
  PKFileOperation *operation = [PKFileOperation imageUploadOperationWithURLString:apiClient.fileUploadURLString image:image];
  operation.requestCompletionBlock = completion;
  
  [apiClient addFileOperation:operation];
  
  return operation;
}

+ (PKRequest *)requestToAttachFileWithId:(NSUInteger)fileId referenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/file/%d/attach", fileId] method:PKAPIRequestMethodPOST];
  
  request.body = [NSDictionary dictionaryWithObjectsAndKeys:
                  [PKConstants stringForReferenceType:referenceType], @"ref_type", 
                  [NSNumber numberWithUnsignedInteger:referenceId], @"ref_id", nil];
  
  return request;
}

@end
