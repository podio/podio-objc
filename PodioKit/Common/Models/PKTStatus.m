//
//  PKTStatus.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 30/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTStatus.h"
#import "PKTByLine.h"
#import "PKTComment.h"
#import "PKTStatusAPI.h"
#import "PKTClient.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTStatus

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"statusID" : @"status_id",
           @"text" : @"value",
           @"createdBy" : @"created_by",
           @"createdOn" : @"created_on",
           };
}

+ (NSValueTransformer *)linkValueTransformer {
  return [NSValueTransformer pkt_URLTransformer];
}

+ (NSValueTransformer *)createdOnValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)createdByValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTByLine class]];
}

+ (NSValueTransformer *)commentsValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTComment class]];
}

#pragma mark - Private

+ (PKTAsyncTask *)performRequestWithResultingStatusObject:(PKTRequest *)request completion:(void (^)(PKTStatus *status, NSError *error))completion {
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  PKTAsyncTask *task = [[requestTask taskByMappingResult:^id(PKTResponse *response) {
    return [[self alloc] initWithDictionary:response.body];
  }] onSuccess:^(PKTStatus *status) {
    if (completion) completion(status, nil);
  } onError:^(NSError *error) {
    if (completion) completion(nil, error);;
  }];
  
  return task;
}

#pragma mark - Public

+ (PKTAsyncTask *)fetchWithID:(NSUInteger)statusID completion:(void (^)(PKTStatus *status, NSError *error))completion {
  NSParameterAssert(completion);
  PKTRequest *request = [PKTStatusAPI requestForStatusMessageWithID:statusID];
  
  return [self performRequestWithResultingStatusObject:request completion:completion];
}

+ (PKTAsyncTask *)addNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID completion:(void (^)(PKTStatus *status, NSError *error))completion {
  PKTRequest *request = [PKTStatusAPI requestToAddNewStatusMessageWithText:text spaceID:spaceID];
  
  return [self performRequestWithResultingStatusObject:request completion:completion];
}

+ (PKTAsyncTask *)addNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID files:(NSArray *)files completion:(void (^)(PKTStatus *status, NSError *error))completion {
  NSArray *fileIDs = [files valueForKey:@"fileID"];
  PKTRequest *request = [PKTStatusAPI requestToAddNewStatusMessageWithText:text spaceID:spaceID files:fileIDs];
  
  return [self performRequestWithResultingStatusObject:request completion:completion];
}

+ (PKTAsyncTask *)addNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID files:(NSArray *)files embedID:(NSUInteger)embedID completion:(void (^)(PKTStatus *status, NSError *error))completion {
  NSArray *fileIDs = [files valueForKey:@"fileID"];
  PKTRequest *request = [PKTStatusAPI requestToAddNewStatusMessageWithText:text spaceID:spaceID files:fileIDs embedID:embedID];
  
  return [self performRequestWithResultingStatusObject:request completion:completion];
}

+ (PKTAsyncTask *)addNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID files:(NSArray *)files embedURL:(NSURL *)embedURL completion:(void (^)(PKTStatus *status, NSError *error))completion {
  NSArray *fileIDs = [files valueForKey:@"fileID"];
  PKTRequest *request = [PKTStatusAPI requestToAddNewStatusMessageWithText:text spaceID:spaceID files:fileIDs embedURL:embedURL];
  
  return [self performRequestWithResultingStatusObject:request completion:completion];
}

@end
