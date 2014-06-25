//
//  PKTFileAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 01/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTFileAPI.h"
#import "NSValueTransformer+PKTConstants.h"

@implementation PKTFileAPI

+ (PKTRequest *)requestToDownloadFileWithURL:(NSURL *)fileURL {
  return [self requestToDownloadFileWithURL:fileURL toLocalFileWithPath:nil];
}

+ (PKTRequest *)requestToDownloadFileWithURL:(NSURL *)fileURL toLocalFileWithPath:(NSString *)filePath {
  PKTRequest *request = [PKTRequest GETRequestWithURL:fileURL parameters:nil];
  
  if ([filePath length] > 0) {
    request.fileData = [PKTRequestFileData fileDataWithFilePath:filePath name:nil fileName:nil mimeType:nil];
  }
  
  return request;
}

+ (PKTRequest *)requestToUploadFileWithData:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mimeType {
  PKTRequest *request = [PKTRequest POSTRequestWithPath:@"/file/" parameters:@{@"filename" : fileName}];
  request.contentType = PKTRequestContentTypeMultipart;
  request.fileData = [PKTRequestFileData fileDataWithData:data name:@"source" fileName:fileName mimeType:mimeType];
  
  return request;
}

+ (PKTRequest *)requestToUploadFileWithPath:(NSString *)filePath fileName:(NSString *)fileName mimeType:(NSString *)mimeType {
  PKTRequest *request = [PKTRequest POSTRequestWithPath:@"/file/" parameters:@{@"filename" : fileName}];
  request.contentType = PKTRequestContentTypeMultipart;
  request.fileData = [PKTRequestFileData fileDataWithFilePath:filePath name:@"source" fileName:fileName mimeType:mimeType];
  
  return request;
}

+ (PKTRequest *)requestToAttachFileWithID:(NSUInteger)fileID referenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType {
  NSDictionary *parameters = @{
    @"ref_type" : [NSValueTransformer pkt_stringFromReferenceType:referenceType],
    @"ref_id" : @(referenceID),
  };
  
  NSString *path = PKTRequestPath(@"/file/%lu/attach", (unsigned long)fileID);
  PKTRequest *request = [PKTRequest POSTRequestWithPath:path parameters:parameters];
  
  return request;
}

@end
