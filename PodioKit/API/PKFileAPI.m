//
//  PKFileAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/21/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKFileAPI.h"

@implementation PKFileAPI

+ (PKHTTPRequestOperation *)uploadFileWithPath:(NSString *)path fileName:(NSString *)fileName completion:(PKRequestCompletionBlock)completion {
  return [self uploadFileWithPath:path fileName:fileName delegate:nil completion:completion];
}

+ (PKHTTPRequestOperation *)uploadFileWithPath:(NSString *)path fileName:(NSString *)fileName delegate:(id)delegate completion:(PKRequestCompletionBlock)completion {
  PKAPIClient *client = [[PKRequestManager sharedManager] apiClient];
  NSURLRequest *request = [client uploadRequestWithFilePath:path fileName:fileName];
  
  PKHTTPRequestOperation *operation = [client operationWithRequest:request completion:completion];

  if (delegate && [delegate respondsToSelector:@selector(setProgress:)]) {
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
      float progress = totalBytesExpectedToWrite > 0 ? (float)totalBytesWritten / (float)totalBytesExpectedToWrite : 0.0f;
      [delegate setProgress:progress];
    }];
  }
  
  [client performOperation:operation];
  
  return operation;
}

+ (PKHTTPRequestOperation *)uploadFileWithImage:(UIImage *)image fileName:(NSString *)fileName completion:(PKRequestCompletionBlock)completion {
  return [self uploadFileWithImage:image fileName:fileName delegate:nil completion:completion];
}

+ (PKHTTPRequestOperation *)uploadFileWithImage:(UIImage *)image fileName:(NSString *)fileName delegate:(id)delegate completion:(PKRequestCompletionBlock)completion {
  PKAPIClient *client = [[PKRequestManager sharedManager] apiClient];
  
  NSData *data = UIImageJPEGRepresentation(image, 0.8f);
  NSURLRequest *request = [client uploadRequestWithData:data mimeType:@"image/jpeg" fileName:fileName];
  
  PKHTTPRequestOperation *operation = [client operationWithRequest:request completion:completion];
  
  if (delegate && [delegate respondsToSelector:@selector(setProgress:)]) {
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
      float progress = totalBytesExpectedToWrite > 0 ? (float)totalBytesWritten / (float)totalBytesExpectedToWrite : 0.0f;
      [delegate setProgress:progress];
    }];
  }
  
  [client performOperation:operation];
  
  return operation;
}

+ (PKHTTPRequestOperation *)downloadFileWithURLString:(NSString *)urlString savePath:(NSString *)savePath delegate:(id)delegate completion:(PKRequestCompletionBlock)completion {
  
  NSURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
  
  PKHTTPRequestOperation *operation = [PKHTTPRequestOperation operationWithRequest:request completion:completion];
  operation.outputStream = [NSOutputStream outputStreamToFileAtPath:savePath append:NO];
  
  if (delegate && [delegate respondsToSelector:@selector(setProgress:)]) {
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
      float progress = totalBytesExpectedToRead > 0 ? (float)totalBytesRead / (float)totalBytesExpectedToRead : 0.0f;
      [delegate setProgress:progress];
    }];
  }
  
  PKAPIClient *client = [[PKRequestManager sharedManager] apiClient];
  [client performOperation:operation];
  
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
