//
//  PKFileAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/21/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
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

+ (PKFileOperation *)uploadFileWithImage:(UIImage *)image fileName:(NSString *)fileName completion:(PKRequestCompletionBlock)completion {
  PKAPIClient *apiClient = [[PKRequestManager sharedManager] apiClient];
  PKFileOperation *operation = [PKFileOperation imageUploadOperationWithURLString:apiClient.fileUploadURLString image:image fileName:fileName];
  operation.requestCompletionBlock = completion;
  
  [apiClient addFileOperation:operation];
  
  return operation;
}

+ (PKRequestOperation *)downloadFileWithURLString:(NSString *)urlString savePath:(NSString *)savePath delegate:(id)delegate completion:(PKRequestCompletionBlock)completion {
  PKRequestOperation *operation = [PKRequestOperation operationWithURLString:urlString method:PKRequestMethodGET body:nil];
  operation.requestCompletionBlock = completion;
  
  operation.downloadProgressDelegate = delegate;
  operation.showAccurateProgress = YES;
  
  operation.downloadDestinationPath = savePath;
  
  [[[PKRequestManager sharedManager] apiClient] addRequestOperation:operation];
  
  return operation;
}

+ (PKRequest *)requestToAttachFileWithId:(NSUInteger)fileId referenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/file/%d/attach", fileId] method:PKRequestMethodPOST];
  
  request.body = @{@"ref_type": [PKConstants stringForReferenceType:referenceType], 
                  @"ref_id": @(referenceId)};
  
  return request;
}

+ (PKRequest *)requestForFilesForLinkedAccountWithId:(NSUInteger)linkedAccountId externalFolderId:(NSString *)externalFolderId limit:(NSUInteger)limit {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/file/linked_account/%d/", linkedAccountId]  method:PKRequestMethodGET];
  
  if (externalFolderId != nil) {
    [request.parameters setObject:externalFolderId forKey:@"external_folder_id"];
  }
  
  if (limit > 0) {
    [request.parameters setObject:[NSString stringWithFormat:@"%d", limit] forKey:@"limit"];
  }
  
  return request;
}

+ (PKRequest *)requestToUploadLinkedAccountFileWithExternalFileId:(NSString *)externalFileId linkedAccountId:(NSUInteger)linkedAccountId {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/file/linked_account/%d/", linkedAccountId]  method:PKRequestMethodPOST];
  request.body = @{@"external_file_id": externalFileId};
  
  return request;
}

+ (PKRequest *)requestToDeleteFileWithId:(NSUInteger)fileId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/file/%d", fileId] method:PKRequestMethodDELETE];
}

@end
