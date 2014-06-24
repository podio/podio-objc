//
//  PKTFileAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 01/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"
#import "PKTConstants.h"

@interface PKTFileAPI : PKTBaseAPI

+ (PKTRequest *)requestToDownloadFileWithURL:(NSURL *)fileURL;
+ (PKTRequest *)requestToDownloadFileWithURL:(NSURL *)fileURL toLocalFileWithPathURL:(NSURL *)pathURL;
+ (PKTRequest *)requestToUploadFileWithData:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mimeType;
+ (PKTRequest *)requestToUploadFileWithURL:(NSURL *)fileURL fileName:(NSString *)fileName mimeType:(NSString *)mimeType;
+ (PKTRequest *)requestToAttachFileWithID:(NSUInteger)fileID referenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType;

@end
