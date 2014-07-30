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

+ (PKTAsyncTask *)fetchProfileWithID:(NSUInteger)profileID completion:(void (^)(PKTProfile *profile, NSError *error))completion;

+ (PKTAsyncTask *)fetchProfileWithUserID:(NSUInteger)userID completion:(void (^)(PKTProfile *profile, NSError *error))completion;

+ (PKTAsyncTask *)fetchProfilesWithIDs:(NSArray *)profileIDs completion:(void (^)(NSArray *profiles, NSError *error))completion;

+ (PKTAsyncTask *)fetchContactsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion;

+ (PKTAsyncTask *)fetchUsersWithOffset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion;

+ (PKTAsyncTask *)fetchWorkspaceContactsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion;

+ (PKTAsyncTask *)fetchContactsByMatchingName:(NSString *)name offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion;

+ (PKTAsyncTask *)fetchUsersByMatchingName:(NSString *)name offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion;

+ (PKTAsyncTask *)fetchWorkspaceContactsByMatchingName:(NSString *)name offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion;

+ (PKTAsyncTask *)fetchContactsByMatchingField:(NSString *)fieldName value:(NSString *)fieldValue offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion;

+ (PKTAsyncTask *)fetchUsersByMatchingField:(NSString *)fieldName value:(NSString *)fieldValue offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion;

+ (PKTAsyncTask *)fetchWorkspaceContactsByMatchingField:(NSString *)fieldName value:(NSString *)fieldValue offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion;

@end
