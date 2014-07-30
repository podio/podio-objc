//
//  PKTOrganization.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTOrganization.h"
#import "PKTWorkspace.h"
#import "PKTFile.h"
#import "PKTOrganizationsAPI.h"
#import "NSValueTransformer+PKTTransformers.h"
#import "NSArray+PKTAdditions.h"

@implementation PKTOrganization

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"organizationID" : @"org_id",
           @"workspaces" : @"spaces",
           @"imageFile" : @"image"
           };
}

+ (NSValueTransformer *)workspacesValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTWorkspace class]];
}

+ (NSValueTransformer *)imageFileValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTFile class]];
}

#pragma mark - API

+ (PKTAsyncTask *)fetchAllWithCompletion:(void (^)(NSArray *organizations, NSError *error))completion {
  NSParameterAssert(completion);
  
  PKTRequest *request = [PKTOrganizationsAPI requestForAllOrganizations];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  PKTAsyncTask *task = [[requestTask taskByMappingResult:^id(PKTResponse *response) {
    return [response.body pkt_mappedArrayWithBlock:^id(NSDictionary *orgDict) {
      return [[self alloc] initWithDictionary:orgDict];
    }];
  }] onSuccess:^(NSArray *orgs) {
    completion(orgs, nil);
  } onError:^(NSError *error) {
    completion(nil, error);
  }];

  return task;
}

+ (PKTAsyncTask *)fetchWithID:(NSUInteger)organizationID completion:(void (^)(PKTOrganization *organization, NSError *error))completion {
  NSParameterAssert(completion);
  
  PKTRequest *request = [PKTOrganizationsAPI requestForOrganizationsWithID:organizationID];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  PKTAsyncTask *task = [[requestTask taskByMappingResult:^id(PKTResponse *response) {
    return [[self alloc] initWithDictionary:response.body];
  }] onSuccess:^(PKTOrganization *org) {
    completion(org, nil);
  } onError:^(NSError *error) {
    completion(nil, error);
  }];

  return task;
}

@end
