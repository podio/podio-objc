//
//  PKTWorkspace.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTWorkspace.h"
#import "PKTWorkspacesAPI.h"
#import "PKTWorkspaceMembersAPI.h"
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

- (PKTAsyncTask *)addMemberWithUserID:(NSUInteger)userID role:(PKTWorkspaceMemberRole)role {
  NSParameterAssert(userID > 0);
  
  return [self addMembersWithUserIDs:@[@(userID)] role:role];
}

- (PKTAsyncTask *)addMemberWithProfileID:(NSUInteger)profileID role:(PKTWorkspaceMemberRole)role {
  NSParameterAssert(profileID > 0);
  
  return [self addMembersWithProfileIDs:@[@(profileID)] role:role];
}

- (PKTAsyncTask *)addMemberWithEmail:(NSString *)email role:(PKTWorkspaceMemberRole)role {
  NSParameterAssert([email length] > 0);
  
  return [self addMembersWithEmails:@[email] role:role];
}

- (PKTAsyncTask *)addMembersWithUserIDs:(NSArray *)userIDs role:(PKTWorkspaceMemberRole)role {
  NSParameterAssert([userIDs count] > 0);
  
  return [self addMembersWithRole:role message:nil userIDs:userIDs profileIDs:nil emails:nil];
}

- (PKTAsyncTask *)addMembersWithProfileIDs:(NSArray *)profileIDs role:(PKTWorkspaceMemberRole)role {
  NSParameterAssert([profileIDs count] > 0);
  
  return [self addMembersWithRole:role message:nil userIDs:nil profileIDs:profileIDs emails:nil];
}

- (PKTAsyncTask *)addMembersWithEmails:(NSArray *)emails role:(PKTWorkspaceMemberRole)role {
  NSParameterAssert([emails count] > 0);
  
  return [self addMembersWithRole:role message:nil userIDs:nil profileIDs:nil emails:emails];
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

- (PKTAsyncTask *)addMembersWithRole:(PKTWorkspaceMemberRole)role message:(NSString *)message userIDs:(NSArray *)userIDs profileIDs:(NSArray *)profileIDs emails:(NSArray *)emails {
  PKTRequest *request = [PKTWorkspaceMembersAPI requestToAddMembersToSpaceWithID:self.spaceID role:role message:message userIDs:userIDs profileIDs:profileIDs emails:emails];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  return task;
}

@end
