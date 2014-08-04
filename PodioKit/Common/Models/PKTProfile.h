//
//  PKTProfile.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"
#import "PKTClient.h"

@interface PKTProfile : PKTModel

@property (nonatomic, assign, readonly) NSUInteger profileID;
@property (nonatomic, assign, readonly) NSUInteger userID;
@property (nonatomic, copy, readonly) NSString *name;

+ (PKTAsyncTask *)fetchProfileWithID:(NSUInteger)profileID;

+ (PKTAsyncTask *)fetchProfileWithUserID:(NSUInteger)userID;

+ (PKTAsyncTask *)fetchProfilesWithIDs:(NSArray *)profileIDs;

+ (PKTAsyncTask *)fetchContactsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKTAsyncTask *)fetchUsersWithOffset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKTAsyncTask *)fetchWorkspaceContactsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKTAsyncTask *)fetchContactsByMatchingName:(NSString *)name offset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKTAsyncTask *)fetchUsersByMatchingName:(NSString *)name offset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKTAsyncTask *)fetchWorkspaceContactsByMatchingName:(NSString *)name offset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKTAsyncTask *)fetchContactsByMatchingField:(NSString *)fieldName value:(NSString *)fieldValue offset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKTAsyncTask *)fetchUsersByMatchingField:(NSString *)fieldName value:(NSString *)fieldValue offset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKTAsyncTask *)fetchWorkspaceContactsByMatchingField:(NSString *)fieldName value:(NSString *)fieldValue offset:(NSUInteger)offset limit:(NSUInteger)limit;

@end
