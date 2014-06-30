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
#import "PKTReferenceObjectFactory.h"
#import "PKTTaskAPI.h"
#import "NSArray+PKTAdditions.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTTask

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
  return [NSValueTransformer pkt_transformerWithBlock:^id(NSDictionary *refDict) {
    return [PKTReferenceObjectFactory referenceObjectFromDictionary:refDict];
  }];
}

+ (NSValueTransformer *)filesValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTFile class]];
}

+ (NSValueTransformer *)commentsValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTComment class]];
}

#pragma mark - Public

+ (void)fetchWithID:(NSUInteger)taskID completion:(void (^)(PKTTask *task, NSError *error))completion {
  NSParameterAssert(completion);
  
  PKTRequest *request = [PKTTaskAPI requestForTaskWithID:taskID];
  
  Class klass = [self class];
  [[self client] performRequest:request completion:^(PKTResponse *response, NSError *error) {
    PKTTask *task = nil;
    if (!error) {
      task = [[klass alloc] initWithDictionary:response.body];
    }
    
    completion(task, error);
  }];
}

+ (void)fetchWithParameters:(PKTTaskRequestParameters *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *tasks, NSError *error))completion {
  NSParameterAssert(completion);
  
  PKTRequest *request = [PKTTaskAPI requestForTasksWithParameters:parameters offset:offset limit:limit];
  
  Class klass = [self class];
  [[self client] performRequest:request completion:^(PKTResponse *response, NSError *error) {
    NSArray *tasks = nil;
    if (!error) {
      tasks = [response.body pkt_mappedArrayWithBlock:^id(NSDictionary *taskDict) {
        return [[klass alloc] initWithDictionary:taskDict];
      }];
    }
    
    completion(tasks, error);
  }];
}

@end
