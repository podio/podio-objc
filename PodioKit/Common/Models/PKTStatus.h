//
//  PKTStatus.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 30/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@class PKTByLine, PKTRequestTaskHandle;

@interface PKTStatus : PKTModel

@property (nonatomic, assign, readonly) NSUInteger statusID;
@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, copy, readonly) NSURL *link;
@property (nonatomic, copy, readonly) PKTByLine *createdBy;
@property (nonatomic, copy, readonly) NSDate *createdOn;
@property (nonatomic, copy, readonly) NSArray *comments;

+ (PKTRequestTaskHandle *)fetchWithID:(NSUInteger)statusID completion:(void (^)(PKTStatus *status, NSError *error))completion;

+ (PKTRequestTaskHandle *)addNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID completion:(void (^)(PKTStatus *status, NSError *error))completion;

+ (PKTRequestTaskHandle *)addNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID files:(NSArray *)files completion:(void (^)(PKTStatus *status, NSError *error))completion;

+ (PKTRequestTaskHandle *)addNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID files:(NSArray *)files embedID:(NSUInteger)embedID completion:(void (^)(PKTStatus *status, NSError *error))completion;

+ (PKTRequestTaskHandle *)addNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID files:(NSArray *)files embedURL:(NSURL *)embedURL completion:(void (^)(PKTStatus *status, NSError *error))completion;

@end
