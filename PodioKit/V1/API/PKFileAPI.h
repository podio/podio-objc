//
//  PKFileAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/21/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKBaseAPI.h"
#import "PKRequestManager.h"

@interface PKFileAPI : PKBaseAPI

+ (PKHTTPRequestOperation *)uploadFileWithPath:(NSString *)filePath fileName:(NSString *)fileName completion:(PKRequestCompletionBlock)completion;
+ (PKHTTPRequestOperation *)uploadFileWithPath:(NSString *)filePath fileName:(NSString *)fileName delegate:(id)delegate completion:(PKRequestCompletionBlock)completion;
+ (PKHTTPRequestOperation *)uploadFileWithPath:(NSString *)filePath fileName:(NSString *)fileName progression:(PKRequestProgressionBlock)progression completion:(PKRequestCompletionBlock)completion;
+ (PKHTTPRequestOperation *)uploadFileWithData:(NSData *)data mimeType:(NSString *)mimeType fileName:(NSString *)fileName completion:(PKRequestCompletionBlock)completion;
+ (PKHTTPRequestOperation *)uploadFileWithData:(NSData *)data mimeType:(NSString *)mimeType fileName:(NSString *)fileName delegate:(id)delegate completion:(PKRequestCompletionBlock)completion;
+ (PKHTTPRequestOperation *)uploadFileWithData:(NSData *)data mimeType:(NSString *)mimeType fileName:(NSString *)fileName progression:(PKRequestProgressionBlock)progression completion:(PKRequestCompletionBlock)completion;

+ (PKHTTPRequestOperation *)downloadFileWithURLString:(NSString *)urlString savePath:(NSString *)savePath delegate:(id)delegate completion:(PKRequestCompletionBlock)completion;
+ (PKHTTPRequestOperation *)downloadFileWithURLString:(NSString *)urlString savePath:(NSString *)savePath progression:(PKRequestProgressionBlock)progression completion:(PKRequestCompletionBlock)completion;

+ (PKRequest *)requestToAttachFileWithId:(NSUInteger)fileId referenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType;
+ (PKRequest *)requestToDeleteFileWithId:(NSUInteger)fileId;

+ (PKRequest *)requestForFilesForLinkedAccountWithId:(NSUInteger)linkedAccountId externalFolderId:(NSString *)externalFolderId limit:(NSUInteger)limit;
+ (PKRequest *)requestToUploadLinkedAccountFileWithExternalFileId:(NSString *)externalFileId linkedAccountId:(NSUInteger)linkedAccountId;

@end
