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
#import "PKTOrganizationAPI.h"
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

+ (void)fetchAllWithCompletion:(void (^)(NSArray *organizations, NSError *error))completion {
  Class objectClass = [self class];
  PKTRequest *request = [PKTOrganizationAPI requestForAllOrganizations];
  [[PKTClient currentClient] performRequest:request completion:^(PKTResponse *response, NSError *error) {
    NSArray *orgs = nil;
    
    if (!error) {
      orgs = [response.body pkt_mappedArrayWithBlock:^id(NSDictionary *orgDict) {
        return [[objectClass alloc] initWithDictionary:orgDict];
      }];
    }
    
    if (completion) completion(orgs, error);
  }];
}

+ (void)fetchWithID:(NSUInteger)organizationID completion:(void (^)(PKTOrganization *organization, NSError *error))completion {
  Class objectClass = [self class];
  PKTRequest *request = [PKTOrganizationAPI requestForOrganizationsWithID:organizationID];
  [[PKTClient currentClient] performRequest:request completion:^(PKTResponse *response, NSError *error) {
    PKTOrganization *org = nil;
    
    if (!error) {
      org = [[objectClass alloc] initWithDictionary:response.body];
    }
    
    if (completion) completion(org, error);
  }];
}

@end
