//
//  PKTFile.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTFile.h"
#import "PKTFilesAPI.h"
#import "NSURL+PKTImageURL.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTFile

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"fileID" : @"file_id",
           @"mimeType" : @"mimetype",
           @"hostedBy" : @"hosted_by",
           @"link" : @"link",
           @"thumbnailLink" : @"thumbnail_link",
           @"createdOn" : @"created_on",
           @"fileDescription" : @"description"
           };
}

+ (NSValueTransformer *)linkValueTransformer {
  return [NSValueTransformer pkt_URLTransformer];
}

+ (NSValueTransformer *)thumbnailLinkValueTransformer {
  return [NSValueTransformer pkt_URLTransformer];
}

+ (NSValueTransformer *)createdOnValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

#pragma mrk - API

+ (PKTAsyncTask *)uploadWithData:(NSData *)data fileName:(NSString *)fileName {
  PKTRequest *request = [PKTFilesAPI requestToUploadFileWithData:data fileName:fileName];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  Class klass = [self class];
  
  PKTAsyncTask *task = [requestTask map:^id(PKTResponse *response) {
    return [[klass alloc] initWithDictionary:response.body];
  }];

  return task;
}

+ (PKTAsyncTask *)uploadWithPath:(NSString *)filePath fileName:(NSString *)fileName {
  PKTRequest *request = [PKTFilesAPI requestToUploadFileWithPath:filePath fileName:fileName];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  Class klass = [self class];
  
  PKTAsyncTask *task = [requestTask map:^id(PKTResponse *response) {
    return [[klass alloc] initWithDictionary:response.body];
  }];
  
  return task;
}

- (PKTAsyncTask *)attachWithReferenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType {
  PKTRequest *request = [PKTFilesAPI requestToAttachFileWithID:self.fileID referenceID:referenceID referenceType:referenceType];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];

  return task;
}

+ (PKTAsyncTask *)downloadFileWithURL:(NSURL *)fileURL {
  NSParameterAssert(fileURL);
  
  PKTRequest *request = [PKTFilesAPI requestToDownloadFileWithURL:fileURL];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  PKTAsyncTask *task = [requestTask map:^id(PKTResponse *response) {
    return response.body;
  }];
  
  return task;
}

+ (PKTAsyncTask *)downloadFileWithURL:(NSURL *)fileURL toFileWithPath:(NSString *)filePath {
  NSParameterAssert(fileURL);
  
  PKTRequest *request = [PKTFilesAPI requestToDownloadFileWithURL:fileURL toLocalFileWithPath:filePath];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  return task;
}

- (PKTAsyncTask *)download {
  return [[self class] downloadFileWithURL:self.link];
}

- (PKTAsyncTask *)downloadToFileWithPath:(NSString *)filePath {
  return [[self class] downloadFileWithURL:self.link toFileWithPath:filePath];
}

- (NSURL *)downloadURLForImageSize:(PKTImageSize)imageSize {
  NSParameterAssert(self.link);
  
  return [self.link pkt_imageURLForSize:imageSize];
}

@end
