//
//  PKTFile.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTFile.h"
#import "PKTFilesAPI.h"
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
           @"createdOn" : @"created_on"
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

- (PKTAsyncTask *)attachWithReferenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType {
  PKTRequest *request = [PKTFilesAPI requestToAttachFileWithID:self.fileID referenceID:referenceID referenceType:referenceType];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];

  return task;
}

- (PKTAsyncTask *)download {
  NSParameterAssert(self.link);
  
  PKTRequest *request = [PKTFilesAPI requestToDownloadFileWithURL:self.link];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  PKTAsyncTask *task = [requestTask map:^id(PKTResponse *response) {
    return response.body;
  }];
  
  return task;
}

- (PKTAsyncTask *)downloadToFileWithPath:(NSString *)filePath {
  NSParameterAssert(self.link);
  
  PKTRequest *request = [PKTFilesAPI requestToDownloadFileWithURL:self.link toLocalFileWithPath:filePath];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  return task;
}

@end
