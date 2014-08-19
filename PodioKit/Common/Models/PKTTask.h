//
//  PKTTask.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"
#import "PKTConstants.h"
#import "PKTClient.h"

@class PKTProfile;
@class PKTByLine;
@class PKTReference;
@class PKTTaskRequestParameters;

@interface PKTTask : PKTModel

@property (nonatomic, assign, readonly) NSUInteger taskID;
@property (nonatomic, assign, readonly) NSUInteger spaceID;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *descr;
@property (nonatomic, assign, readonly) PKTTaskStatus status;
@property (nonatomic, assign) BOOL isPrivate;
@property (nonatomic, copy) NSDate *dueOn;
@property (nonatomic, copy) PKTProfile *responsible;
@property (nonatomic, copy, readonly) NSURL *link;
@property (nonatomic, copy, readonly) PKTByLine *createdBy;
@property (nonatomic, copy, readonly) NSDate *createdOn;
@property (nonatomic, copy, readonly) PKTByLine *completedBy;
@property (nonatomic, copy, readonly) NSDate *completedOn;
@property (nonatomic, copy) PKTReference *reference;
@property (nonatomic, copy, readonly) NSArray *files;
@property (nonatomic, copy, readonly) NSArray *comments;

+ (instancetype)taskWithText:(NSString *)text;

+ (PKTAsyncTask *)fetchWithID:(NSUInteger)taskID;

+ (PKTAsyncTask *)fetchWithParameters:(PKTTaskRequestParameters *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit;

- (PKTAsyncTask *)complete;

- (PKTAsyncTask *)incomplete;

- (PKTAsyncTask *)assignToUser:(PKTProfile *)profile;

- (PKTAsyncTask *)save;

- (PKTAsyncTask *)deleteTask;

@end
