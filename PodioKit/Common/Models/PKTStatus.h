//
//  PKTStatus.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 30/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@class PKTByLine, PKTAsyncTask;

@interface PKTStatus : PKTModel

@property (nonatomic, assign, readonly) NSUInteger statusID;
@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, copy, readonly) NSURL *link;
@property (nonatomic, copy, readonly) PKTByLine *createdBy;
@property (nonatomic, copy, readonly) NSDate *createdOn;
@property (nonatomic, copy, readonly) NSArray *comments;

+ (PKTAsyncTask *)fetchWithID:(NSUInteger)statusID;

+ (PKTAsyncTask *)addNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID;

+ (PKTAsyncTask *)addNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID files:(NSArray *)files;

+ (PKTAsyncTask *)addNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID files:(NSArray *)files embedID:(NSUInteger)embedID;

+ (PKTAsyncTask *)addNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID files:(NSArray *)files embedURL:(NSURL *)embedURL;

@end
