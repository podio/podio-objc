//
//  PKTTask.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"
#import "PKTClient.h"

@class PKTProfile;
@class PKTByLine;
@class PKTReference;

typedef NS_ENUM(NSUInteger, PKTTaskStatus) {
  PKTTaskStatusActive,
  PKTTaskStatusCompleted,
};

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

+ (void)fetchWithID:(NSUInteger)taskID completion:(void (^)(PKTTask *task, NSError *error))completion;

+ (void)fetchWithParameters:(PKTTaskRequestParameters *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *tasks, NSError *error))completion;

- (void)saveWithCompletion:(PKTRequestCompletionBlock)completion;

@end
