//
//  PKTTask.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTTask.h"
#import "PKTProfile.h"
#import "PKTByLine.h"
#import "PKTFile.h"
#import "PKTComment.h"
#import "PKTProfile.h"
#import "PKTReference.h"
#import "PKTTasksAPI.h"
#import "NSArray+PKTAdditions.h"
#import "NSValueTransformer+PKTTransformers.h"
#import "PKTMacros.h"

@interface PKTTask ()

@property (nonatomic, assign, readwrite) NSUInteger taskID;
@property (nonatomic, assign, readwrite) PKTTaskStatus status;

@end

@implementation PKTTask

- (instancetype)init {
  return [self initWithText:nil];
}

- (instancetype)initWithText:(NSString *)text {
  self = [super init];
  if (!self) return nil;
  
  _text = [text copy];
  _isPrivate = YES;
  
  return self;
}

+ (instancetype)taskWithText:(NSString *)text {
  return [[self alloc] initWithText:text];
}

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"taskID" : @"task_id",
           @"spaceID" : @"space_id",
           @"descr" : @"description",
           @"isPrivate" : @"private",
           @"dueOn" : @"due_on",
           @"completedBy" : @"completed_by",
           @"completedOn" : @"completed_on",
           @"createdBy" : @"created_by",
           @"createdOn" : @"created_on",
           @"referenceObject" : @"ref"
           };
}

+ (NSValueTransformer *)statusValueTransformer {
  return [NSValueTransformer pkt_transformerWithDictionary:@{@"active" : @(PKTTaskStatusActive),
                                                             @"completed" : @(PKTTaskStatusCompleted)}];
}

+ (NSValueTransformer *)dueOnValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)responsibleValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTProfile class]];
}

+ (NSValueTransformer *)completedByValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTByLine class]];
}

+ (NSValueTransformer *)completedOnValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)linkValueTransformer {
  return [NSValueTransformer pkt_URLTransformer];
}

+ (NSValueTransformer *)createdByValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTByLine class]];
}

+ (NSValueTransformer *)createdOnValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)referenceObjectValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTReference class]];
}

+ (NSValueTransformer *)filesValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTFile class]];
}

+ (NSValueTransformer *)commentsValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTComment class]];
}

#pragma mark - Public

+ (PKTAsyncTask *)fetchWithID:(NSUInteger)taskID {
  PKTRequest *request = [PKTTasksAPI requestForTaskWithID:taskID];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  PKTAsyncTask *task = [requestTask map:^id(PKTResponse *response) {
    return [[self alloc] initWithDictionary:response.body];
  }];

  return task;
}

+ (PKTAsyncTask *)fetchWithParameters:(PKTTaskRequestParameters *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKTRequest *request = [PKTTasksAPI requestForTasksWithParameters:parameters offset:offset limit:limit];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  PKTAsyncTask *task = [requestTask map:^id(PKTResponse *response) {
    return [response.body pkt_mappedArrayWithBlock:^id(NSDictionary *taskDict) {
      return [[self alloc] initWithDictionary:taskDict];
    }];
  }];

  return task;
}

- (PKTAsyncTask *)complete {
  PKTRequest *request = [PKTTasksAPI requestToCompleteTaskWithID:self.taskID];
  PKTAsyncTask *task = [self updateStatus:PKTTaskStatusCompleted onSuccessfulRequest:request];
  
  return task;
}

- (PKTAsyncTask *)incomplete {
  PKTRequest *request = [PKTTasksAPI requestToIncompleteTaskWithID:self.taskID];
  PKTAsyncTask *task = [self updateStatus:PKTTaskStatusActive onSuccessfulRequest:request];
  
  return task;
}

- (PKTAsyncTask *)assignToUser:(PKTProfile *)profile {
  PKTRequest *request = [PKTTasksAPI requestToAssignTaskWithID:self.taskID userID:profile.userID];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  PKTProfile *previousResponsible = self.responsible;
  
  PKT_WEAK_SELF weakSelf = self;

  task = [task then:^(id result, NSError *error) {
    PKT_STRONG(weakSelf) strongSelf = weakSelf;
    
    if (!error) {
      strongSelf.responsible = profile;
    } else {
      strongSelf.responsible = previousResponsible;
    }
  }];
  
  return task;
}

- (PKTAsyncTask *)save {
  NSAssert(self.text, @"The 'text' property of task %@ cannot be nil", self);
  
  NSArray *fileIDs = [self.files valueForKey:@"fileID"];
  
  PKTRequest *request = nil;
  if (self.taskID == 0) {
    request = [PKTTasksAPI requestToCreateTaskWithText:self.text
                                          description:self.descr
                                                dueOn:self.dueOn
                                            isPrivate:self.isPrivate
                                    responsibleUserID:self.responsible.userID
                                          referenceID:self.reference.referenceID
                                        referenceType:self.reference.referenceType
                                                files:fileIDs];
  } else {
    request = [PKTTasksAPI requestToUpdateTaskWithID:self.taskID
                                               text:self.text
                                        description:self.descr
                                              dueOn:self.dueOn
                                          isPrivate:self.isPrivate
                                  responsibleUserID:self.responsible.userID
                                        referenceID:self.reference.referenceID
                                      referenceType:self.reference.referenceType
                                              files:fileIDs];
  }
  
  
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  PKT_WEAK_SELF weakSelf = self;
  
  task = [task then:^(PKTResponse *response, NSError *error) {
    if (response) {
      weakSelf.taskID = [response.body[@"task_id"] unsignedIntegerValue];
    }
  }];

  return task;
}

- (PKTAsyncTask *)deleteTask {
  PKTRequest *request = [PKTTasksAPI requestToDeleteTaskWithID:self.taskID];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  return task;
}

#pragma mark - Private

- (PKTAsyncTask *)updateStatus:(PKTTaskStatus)status onSuccessfulRequest:(PKTRequest *)request {
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  PKTTaskStatus previousStatus = self.status;
  
  PKT_WEAK_SELF weakSelf = self;
  
  task = [task then:^(id result, NSError *error) {
    PKT_STRONG(weakSelf) strongSelf = weakSelf;
    
    if (!error) {
      strongSelf.status = status;
    } else {
      strongSelf.status = previousStatus;
    }
  }];
  
  return task;
}

@end
