//
//  PKFileAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/21/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKFileAPI.h"

// Informal protocol to suppress warnings when calling setProgress: on an id object
// since no PodioKit classes respond to it, but UIKit classes like UIProgressView does.
@interface NSObject (PKFileAPIProgressDelegate)

- (void)setProgress:(float)progress;

@end

@implementation PKFileAPI

+ (PKRequestProgressionBlock)progressionBlockForDelegate:(id)delegate {
  PKRequestProgressionBlock progressionBlock;
  if ([delegate respondsToSelector:@selector(setProgress:)]) {
    progressionBlock = ^(float progress){
      [delegate setProgress:progress];
    };
  } else {
    progressionBlock = nil;
  }
  return progressionBlock;
}

+ (PKHTTPRequestOperation *)uploadFileWithPath:(NSString *)path fileName:(NSString *)fileName completion:(PKRequestCompletionBlock)completion {
  return [self uploadFileWithPath:path fileName:fileName progression:nil completion:completion];
}

+ (PKHTTPRequestOperation *)uploadFileWithPath:(NSString *)path fileName:(NSString *)fileName delegate:(id)delegate completion:(PKRequestCompletionBlock)completion {
  PKRequestProgressionBlock progression = [self progressionBlockForDelegate:delegate];
  return [self uploadFileWithPath:path fileName:fileName progression:progression completion:completion];
}

+ (PKHTTPRequestOperation *)uploadFileWithPath:(NSString *)path fileName:(NSString *)fileName progression:(PKRequestProgressionBlock)progression completion:(PKRequestCompletionBlock)completion {
  PKAPIClient *client = [[PKRequestManager sharedManager] apiClient];
  NSURLRequest *request = [client uploadRequestWithFilePath:path fileName:fileName];
  
  PKHTTPRequestOperation *operation = [client operationWithRequest:request completion:completion];
  [operation setRequestUploadProgressionBlock:progression];
  
  [client performOperation:operation];
  
  return operation;
}

+ (PKHTTPRequestOperation *)uploadFileWithData:(NSData *)data mimeType:(NSString *)mimeType fileName:(NSString *)fileName completion:(PKRequestCompletionBlock)completion {
  return [self uploadFileWithData:data mimeType:mimeType fileName:fileName progression:nil completion:completion];
}

+ (PKHTTPRequestOperation *)uploadFileWithData:(NSData *)data mimeType:(NSString *)mimeType fileName:(NSString *)fileName delegate:(id)delegate completion:(PKRequestCompletionBlock)completion {
  PKRequestProgressionBlock progression = [self progressionBlockForDelegate:delegate];
  return [self uploadFileWithData:data mimeType:mimeType fileName:fileName progression:progression completion:completion];
}

+ (PKHTTPRequestOperation *)uploadFileWithData:(NSData *)data mimeType:(NSString *)mimeType fileName:(NSString *)fileName progression:(PKRequestProgressionBlock)progression completion:(PKRequestCompletionBlock)completion {
  PKAPIClient *client = [[PKRequestManager sharedManager] apiClient];
  
  NSURLRequest *request = [client uploadRequestWithData:data mimeType:mimeType fileName:fileName];
  PKHTTPRequestOperation *operation = [client operationWithRequest:request completion:completion];
  [operation setRequestUploadProgressionBlock:progression];
  
  [client performOperation:operation];
  
  return operation;
}

+ (PKHTTPRequestOperation *)downloadFileWithURLString:(NSString *)urlString savePath:(NSString *)savePath delegate:(id)delegate completion:(PKRequestCompletionBlock)completion {
  PKRequestProgressionBlock progression = [self progressionBlockForDelegate:delegate];
  return [self downloadFileWithURLString:urlString savePath:savePath progression:progression completion:completion];
}

+ (PKHTTPRequestOperation *)downloadFileWithURLString:(NSString *)urlString savePath:(NSString *)savePath progression:(PKRequestProgressionBlock)progression completion:(PKRequestCompletionBlock)completion {
  PKAPIClient *client = [[PKRequestManager sharedManager] apiClient];
  
  NSMutableURLRequest *request = [client requestWithURL:[NSURL URLWithString:urlString]];
  PKHTTPRequestOperation *operation = [PKHTTPRequestOperation operationWithRequest:request completion:completion];
  operation.outputStream = [NSOutputStream outputStreamToFileAtPath:savePath append:NO];
  [operation setRequestDownloadProgressionBlock:progression];
  
  [client performOperation:operation];
  
  return operation;
}

+ (PKRequest *)requestToAttachFileWithId:(NSUInteger)fileId referenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/file/%ld/attach", (unsigned long)fileId] method:PKRequestMethodPOST];
  
  request.body = @{@"ref_type": [PKConstants stringForReferenceType:referenceType], 
                  @"ref_id": @(referenceId)};
  
  return request;
}

+ (PKRequest *)requestToDeleteFileWithId:(NSUInteger)fileId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/file/%ld", (unsigned long)fileId] method:PKRequestMethodDELETE];
}

+ (PKRequest *)requestForFilesForLinkedAccountWithId:(NSUInteger)linkedAccountId externalFolderId:(NSString *)externalFolderId limit:(NSUInteger)limit {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/file/linked_account/%ld/", (unsigned long)linkedAccountId]  method:PKRequestMethodGET];
  
  if (externalFolderId != nil) {
    [request.parameters setObject:externalFolderId forKey:@"external_folder_id"];
  }
  
  if (limit > 0) {
    [request.parameters setObject:[NSString stringWithFormat:@"%ld", (unsigned long)limit] forKey:@"limit"];
  }
  
  return request;
}

+ (PKRequest *)requestToUploadLinkedAccountFileWithExternalFileId:(NSString *)externalFileId linkedAccountId:(NSUInteger)linkedAccountId {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/file/linked_account/%ld/", (unsigned long)linkedAccountId]  method:PKRequestMethodPOST];
  request.body = @{@"external_file_id": externalFileId};
  
  return request;
}

@end
