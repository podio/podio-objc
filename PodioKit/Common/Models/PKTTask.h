//
//  PKTTask.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTObject.h"

@class PKTProfile;
@class PKTByLine;

typedef NS_ENUM(NSUInteger, PKTTaskStatus) {
  PKTTaskStatusActive,
  PKTTaskStatusCompleted,
};

@class PKTTaskRequestParameters;

@interface PKTTask : PKTObject

@property (nonatomic, assign, readonly) NSUInteger taskID;
@property (nonatomic, assign, readonly) NSUInteger spaceID;
@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, copy, readonly) NSString *descr;
@property (nonatomic, assign, readonly) PKTTaskStatus status;
@property (nonatomic, assign, readonly) BOOL isPrivate;
@property (nonatomic, copy, readonly) NSDate *dueOn;
@property (nonatomic, copy, readonly) PKTProfile *responsible;
@property (nonatomic, copy, readonly) NSURL *link;
@property (nonatomic, copy, readonly) PKTByLine *createdBy;
@property (nonatomic, copy, readonly) NSDate *createdOn;
@property (nonatomic, copy, readonly) PKTByLine *completedBy;
@property (nonatomic, copy, readonly) NSDate *completedOn;
@property (nonatomic, strong, readonly) id referenceObject;
@property (nonatomic, copy, readonly) NSArray *files;
@property (nonatomic, copy, readonly) NSArray *comments;

+ (void)fetchWithID:(NSUInteger)taskID completion:(void (^)(PKTTask *task, NSError *error))completion;

+ (void)fetchWithParameters:(PKTTaskRequestParameters *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *tasks, NSError *error))completion;

@end
