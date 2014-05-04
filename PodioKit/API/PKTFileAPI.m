//
//  PKTFileAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 01/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTFileAPI.h"

@implementation PKTFileAPI

+ (PKTRequest *)requestToUploadFileWithData:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mimeType {
  PKTRequest *request = [PKTRequest POSTRequestWithPath:@"/file/" parameters:@{@"filename" : fileName}];
  request.contentType = PKTRequestContentTypeMultipart;
  request.fileData = [PKTRequestFileData fileDataWithData:data name:@"source" fileName:fileName mimeType:mimeType];
  
  return request;
}

+ (PKTRequest *)requestToUploadFileWithURL:(NSURL *)fileURL fileName:(NSString *)fileName mimeType:(NSString *)mimeType {
  PKTRequest *request = [PKTRequest POSTRequestWithPath:@"/file/" parameters:@{@"filename" : fileName}];
  request.contentType = PKTRequestContentTypeMultipart;
  request.fileData = [PKTRequestFileData fileDataWithFileURL:fileURL name:@"source" fileName:fileName mimeType:mimeType];
  
  return request;
}

@end
