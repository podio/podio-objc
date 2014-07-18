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

@interface PKTTask ()

@property (nonatomic, assign, readwrite) NSUInteger taskID;

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

+ (PKTRequestTaskHandle *)fetchWithID:(NSUInteger)taskID completion:(void (^)(PKTTask *task, NSError *error))completion {
  NSParameterAssert(completion);
  
  PKTRequest *request = [PKTTasksAPI requestForTaskWithID:taskID];
  
  Class klass = [self class];
  PKTRequestTaskHandle *handle = [[PKTClient currentClient] performRequest:request completion:^(PKTResponse *response, NSError *error) {
    PKTTask *task = nil;
    if (!error) {
      task = [[klass alloc] initWithDictionary:response.body];
    }
    
    completion(task, error);
  }];

  return handle;
}

+ (PKTRequestTaskHandle *)fetchWithParameters:(PKTTaskRequestParameters *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *tasks, NSError *error))completion {
  NSParameterAssert(completion);
  
  PKTRequest *request = [PKTTasksAPI requestForTasksWithParameters:parameters offset:offset limit:limit];
  
  Class klass = [self class];
  PKTRequestTaskHandle *handle = [[PKTClient currentClient] performRequest:request completion:^(PKTResponse *response, NSError *error) {
    NSArray *tasks = nil;
    if (!error) {
      tasks = [response.body pkt_mappedArrayWithBlock:^id(NSDictionary *taskDict) {
        return [[klass alloc] initWithDictionary:taskDict];
      }];
    }
    
    completion(tasks, error);
  }];

  return handle;
}

- (PKTRequestTaskHandle *)saveWithCompletion:(PKTRequestCompletionBlock)completion {
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
  
  
  // Intentiaonally strongly capture self to make sure the request completes even if the local instance is
  // not referenced from anywhere else
  PKTRequestTaskHandle *handle = [[PKTClient currentClient] performRequest:request completion:^(PKTResponse *response, NSError *error) {
    if (!error && self.taskID == 0) {
      self.taskID = [response.body[@"task_id"] unsignedIntegerValue];
    }
    
    if (completion) completion(response, error);
  }];

  return handle;
}

@end
