//
//  PKTaskMappingTest.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/12/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKTaskMappingTests.h"
#import "PKTestMappingProvider.h"
#import "PKDefaultObjectRepository.h"
#import "PKTestTaskMapping.h"
#import "PKTestTask.h"
#import "JSONKit.h"
#import "PKAssert.h"


@interface PKTaskMappingTests ()

- (PKObjectMapper *)createObjectMapperWithMapping:(PKObjectMapping *)mapping;

- (id)dataWithContentsOfJSONFile:(NSString *)filename;

- (void)validateTask:(PKTestTask *)task;

@end

@implementation PKTaskMappingTests

- (PKObjectMapper *)createObjectMapperWithMapping:(PKObjectMapping *)mapping {
  PKTestMappingProvider *mappingProvider = [[PKTestMappingProvider alloc] init];
  PKDefaultObjectRepository *repository = [PKDefaultObjectRepository repository];
  
  PKObjectMapper *mapper = [[PKObjectMapper alloc] initWithProvider:mappingProvider repository:repository];
  mapper.delegate = self;
  mapper.mapping = mapping;
  
  return mapper;
}

- (id)dataWithContentsOfJSONFile:(NSString *)filename {
  NSURL *fileURL = [[NSBundle bundleForClass:[self class]] URLForResource:filename withExtension:@"json"];
  
  id data = [[NSData dataWithContentsOfURL:fileURL] objectFromJSONData];
  STAssertNotNil(data, @"Unable to parse JSON data from file %@", filename);
  
  return data;
}

#pragma mark - Tests

- (void)testGetActiveTasks {
  id data = [self dataWithContentsOfJSONFile:@"GetActiveTasks"];
  
  PKObjectMapper *mapper = [self createObjectMapperWithMapping:[PKTestTaskMapping mapping]];
  mapper.mappingBlock = ^(id obj) {
    [obj setValue:[NSNumber numberWithInt:PKTaskTypeActive] forKey:@"type"];
  };
  
  NSArray *result = [mapper performMappingWithData:data];
  
  PKAssertEquals([result count], 5);
  [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [self validateTask:obj];
  }];
}

- (void)testGetTask {
  id data = [self dataWithContentsOfJSONFile:@"GetTask"];
  
  PKObjectMapper *mapper = [self createObjectMapperWithMapping:[PKTestTaskMapping mapping]];
  mapper.mappingBlock = ^(id obj) {
    [obj setValue:[NSNumber numberWithInt:PKTaskTypeActive] forKey:@"type"];
  };
  
  id task = [mapper performMappingWithData:data];
  STAssertTrue([task isKindOfClass:[PKTestTask class]], @"Wrong class, expected PKTask, got %@", [task class]);
  [self validateTask:task];
}

- (void)validateTask:(PKTestTask *)task {
  PKAssertGreaterThanZero(task.taskId);
  PKAssertNotNil(task.text);
  PKAssertGreaterThanZero(task.type);
  PKAssertGreaterThanZero(task.status);
  PKAssertNotNil(task.createdOn);
}

@end
