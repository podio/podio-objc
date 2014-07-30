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

+ (PKTAsyncTask *)uploadWithData:(NSData *)data fileName:(NSString *)fileName completion:(void (^)(PKTFile *file, NSError *error))completion {
  PKTRequest *request = [PKTFilesAPI requestToUploadFileWithData:data fileName:fileName];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  Class klass = [self class];
  
  PKTAsyncTask *task = [[requestTask taskByMappingResult:^id(PKTResponse *response) {
    return [[klass alloc] initWithDictionary:response.body];
  }] onSuccess:^(PKTFile *file) {
    if (completion) completion(file, nil);
  } onError:^(NSError *error) {
    if (completion) completion(nil, error);;
  }];

  return task;
}

- (PKTAsyncTask *)attachWithReferenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType completion:(PKTRequestCompletionBlock)completion {
  PKTRequest *request = [PKTFilesAPI requestToAttachFileWithID:self.fileID referenceID:referenceID referenceType:referenceType];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  [task onSuccess:^(PKTResponse *response) {
    if (completion) completion(response, nil);
  } onError:^(NSError *error) {
    if (completion) completion(nil, error);;
  }];
  
  return task;
}

- (PKTAsyncTask *)downloadWithCompletion:(void (^)(NSData *data, NSError *error))completion {
  NSParameterAssert(self.link);
  NSParameterAssert(completion);
  
  PKTRequest *request = [PKTFilesAPI requestToDownloadFileWithURL:self.link];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  PKTAsyncTask *task = [[requestTask taskByMappingResult:^id(PKTResponse *response) {
    return response.body;
  }] onSuccess:^(id body) {
    completion(body, nil);
  } onError:^(NSError *error) {
    completion(nil, error);;
  }];
  
  return task;
}

- (PKTAsyncTask *)downloadToFileWithPath:(NSString *)filePath completion:(void (^)(BOOL success, NSError *error))completion {
  NSParameterAssert(self.link);
  
  PKTRequest *request = [PKTFilesAPI requestToDownloadFileWithURL:self.link toLocalFileWithPath:filePath];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  [task onSuccess:^(id body) {
    completion(@YES, nil);
  } onError:^(NSError *error) {
    completion(nil, error);;
  }];
  
  return task;
}

@end
