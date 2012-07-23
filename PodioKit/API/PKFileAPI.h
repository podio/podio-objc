//
//  PKFileAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/21/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKBaseAPI.h"
#import "PKFileOperation.h"
#import "PKRequestManager.h"

@interface PKFileAPI : PKBaseAPI

+ (PKFileOperation *)uploadFileWithPath:(NSString *)filePath fileName:(NSString *)fileName completion:(PKRequestCompletionBlock)completion;
+ (PKFileOperation *)uploadFileWithImage:(UIImage *)image fileName:(NSString *)fileName completion:(PKRequestCompletionBlock)completion;

+ (PKRequestOperation *)downloadFileWithURLString:(NSString *)urlString savePath:(NSString *)savePath delegate:(id)delegate completion:(PKRequestCompletionBlock)completion;

+ (PKRequest *)requestToAttachFileWithId:(NSUInteger)fileId referenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType;

+ (PKRequest *)requestForFilesForLinkedAccountWithId:(NSUInteger)linkedAccountId externalFolderId:(NSString *)externalFolderId limit:(NSUInteger)limit;
+ (PKRequest *)requestToUploadLinkedAccountFileWithExternalFileId:(NSString *)externalFileId linkedAccountId:(NSUInteger)linkedAccountId;

+ (PKRequest *)requestToDeleteFileWithId:(NSUInteger)fileId;

@end
