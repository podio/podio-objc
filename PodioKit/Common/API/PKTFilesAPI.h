//
//  PKTFilesAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 01/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"
#import "PKTConstants.h"

@interface PKTFilesAPI : PKTBaseAPI

+ (PKTRequest *)requestToDownloadFileWithURL:(NSURL *)fileURL;
+ (PKTRequest *)requestToDownloadFileWithURL:(NSURL *)fileURL toLocalFileWithPath:(NSString *)filePath;
+ (PKTRequest *)requestToUploadFileWithData:(NSData *)data fileName:(NSString *)fileName;
+ (PKTRequest *)requestToUploadFileWithPath:(NSString *)filePath fileName:(NSString *)fileName;
+ (PKTRequest *)requestToAttachFileWithID:(NSUInteger)fileID referenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType;

@end
