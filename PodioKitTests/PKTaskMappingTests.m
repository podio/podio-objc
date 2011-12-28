//
//  PKTaskMappingTest.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/12/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKTaskMappingTests.h"
#import "PKDefaultMappingProvider.h"
#import "PKDefaultObjectRepository.h"
#import "PKTaskMapping.h"
#import "PKTask.h"
#import "JSONKit.h"
#import "PKAssert.h"


@interface PKTaskMappingTests ()

- (PKObjectMapper *)createObjectMapperWithMapping:(PKObjectMapping *)mapping;

- (id)dataWithContentsOfJSONFile:(NSString *)filename;

- (void)validateTask:(PKTask *)task;

@end

@implementation PKTaskMappingTests

- (PKObjectMapper *)createObjectMapperWithMapping:(PKObjectMapping *)mapping {
  PKDefaultMappingProvider *mappingProvider = [[PKDefaultMappingProvider alloc] init];
  PKObjectMapper *mapper = [[[PKObjectMapper alloc] initWithMappingProvider:mappingProvider] autorelease];
  [mappingProvider release];
  
  mapper.repository = [PKDefaultObjectRepository repository];
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
  
  PKObjectMapper *mapper = [self createObjectMapperWithMapping:[PKTaskMapping mapping]];
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
  
  PKObjectMapper *mapper = [self createObjectMapperWithMapping:[PKTaskMapping mapping]];
  mapper.mappingBlock = ^(id obj) {
    [obj setValue:[NSNumber numberWithInt:PKTaskTypeActive] forKey:@"type"];
  };
  
  id task = [mapper performMappingWithData:data];
  STAssertTrue([task isKindOfClass:[PKTask class]], @"Wrong class, expected PKTask, got %@", [task class]);
  [self validateTask:task];
}

- (void)validateTask:(PKTask *)task {
  PKAssertGreaterThanZero(task.taskId);
  PKAssertNotNil(task.text);
  PKAssertGreaterThanZero(task.type);
  PKAssertGreaterThanZero(task.status);
  PKAssertNotNil(task.createdOn);
}

@end
