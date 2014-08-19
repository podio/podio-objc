//
//  PKTWorkspace.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTWorkspace.h"
#import "PKTWorkspacesAPI.h"
#import "PKTClient.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTWorkspace

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"spaceID" : @"space_id",
           @"organizationID" : @"org_id",
           @"linkURL" : @"url"
           };
}

+ (NSValueTransformer *)linkURLValueTransformer {
  return [NSValueTransformer pkt_URLTransformer];
}

#pragma mark - Public

+ (PKTAsyncTask *)fetchWorkspaceWithID:(NSUInteger)workspaceID {
  PKTRequest *request = [PKTWorkspacesAPI requestForWorkspaceWithID:workspaceID];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  return [task map:^id(NSDictionary *workspaceDict) {
    return [[self alloc] initWithDictionary:workspaceDict];
  }];
}

+ (PKTAsyncTask *)createWorkspaceWithName:(NSString *)name organizationID:(NSUInteger)organizationID {
  return [self createWorkspaceWithName:name organizationID:organizationID privacy:PKTWorkspacePrivacyDefault];
}

+ (PKTAsyncTask *)createOpenWorkspaceWithName:(NSString *)name organizationID:(NSUInteger)organizationID {
  return [self createWorkspaceWithName:name organizationID:organizationID privacy:PKTWorkspacePrivacyOpen];
}

+ (PKTAsyncTask *)createPrivateWorkspaceWithName:(NSString *)name organizationID:(NSUInteger)organizationID {
  return [self createWorkspaceWithName:name organizationID:organizationID privacy:PKTWorkspacePrivacyClosed];
}

#pragma mark - Private

+ (PKTAsyncTask *)createWorkspaceWithName:(NSString *)name organizationID:(NSUInteger)organizationID privacy:(PKTWorkspacePrivacy)privacy {
  PKTRequest *request = [PKTWorkspacesAPI requestToCreateWorkspaceWithName:name organizationID:organizationID privacy:PKTWorkspacePrivacyDefault];
  
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  return [requestTask map:^id(PKTResponse *response) {
    NSMutableDictionary *dict = [response.body mutableCopy];
    dict[@"name"] = name;
    dict[@"org_id"] = @(organizationID);
    
    return [[self alloc] initWithDictionary:dict];
  }];
}

@end
