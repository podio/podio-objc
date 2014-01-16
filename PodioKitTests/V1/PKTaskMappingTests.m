//
//  PKTaskMappingTest.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/12/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKTaskMappingTests.h"
#import "PKTestMappingProvider.h"
#import "PKDefaultObjectRepository.h"
#import "PKTestTaskMapping.h"
#import "PKTestTask.h"

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
  
  id data = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:fileURL] options:0 error:nil];
  XCTAssertNotNil(data, @"Unable to parse JSON data from file %@", filename);
  
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
  expect(result).to.haveCountOf(5);
  
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
  expect(task).to.beInstanceOf([PKTestTask class]);
  [self validateTask:task];
}

- (void)validateTask:(PKTestTask *)task {
  expect(task.taskId).to.beGreaterThan(0);
  expect(task.text).notTo.beNil();
  expect(task.type).to.beGreaterThan(0);
  expect(task.status).to.beGreaterThan(0);
  expect(task.createdOn).notTo.beNil();
}

@end
