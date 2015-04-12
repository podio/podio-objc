//
//  PKTURLSessionTaskDelegateTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/04/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "PKTURLSessionTaskDelegate.h"
#import "PKTResponse.h"

@interface PKTURLSessionTaskDelegateTests : XCTestCase

@property (nonatomic, strong) dispatch_queue_t processingQueue;

@end

@implementation PKTURLSessionTaskDelegateTests

- (void)setUp {
  [super setUp];
  
  self.processingQueue = dispatch_queue_create("com.podio.podiokit.PKTURLSessionTaskDelegateTests", DISPATCH_QUEUE_CONCURRENT);
}

- (void)tearDown {
  self.processingQueue = nil;
  [super tearDown];
}

- (void)testCompletionWithSuccess {
  __block PKTResponse *occurredResponse = nil;
  __block NSError *occurredError = nil;
  
  PKTRequest *request = [PKTRequest GETRequestWithPath:@"/some/path" parameters:nil];
  PKTURLSessionTaskDelegate *delegate = [[PKTURLSessionTaskDelegate alloc] initWithRequest:request
                                                                   responseProcessingQueue:self.processingQueue
                                                                             progressBlock:nil
                                                                      responseProcessBlock:nil
                                                                           completionBlock:^(PKTResponse *response, NSError *error) {
    occurredResponse = response;
    occurredError = error;
  }];
  
  NSURLSessionDataTask *mockTask = [[self class] mockTaskWithResponseStatusCode:200];
  [delegate task:mockTask didCompleteWithError:nil];
  
  expect(occurredResponse).willNot.beNil();
  expect(occurredError).will.beNil();
}

- (void)testCompletionWithTransformedResponse {
  __block PKTResponse *occurredResponse = nil;
  __block NSError *occurredError = nil;
  
  PKTRequest *request = [PKTRequest GETRequestWithPath:@"/some/path" parameters:nil];
  PKTURLSessionTaskDelegate *delegate = [[PKTURLSessionTaskDelegate alloc] initWithRequest:request
                                                                   responseProcessingQueue:self.processingQueue
                                                                             progressBlock:nil
                                                                      responseProcessBlock:^id(NSURLResponse *response, NSData *data, PKTURLSessionTaskDelegate *delegate) {
    return @"A new value";
  } completionBlock:^(PKTResponse *response, NSError *error) {
    occurredResponse = response;
    occurredError = error;
  }];
  
  NSURLSessionDataTask *mockTask = [[self class] mockTaskWithResponseStatusCode:200];
  [delegate task:mockTask didCompleteWithError:nil];
  
  expect(occurredResponse.body).will.equal(@"A new value");
  expect(occurredError).will.beNil();
}

- (void)testCompletionWithServerError {
  __block NSError *occurredError = nil;
  
  PKTRequest *request = [PKTRequest GETRequestWithPath:@"/some/path" parameters:nil];
  PKTURLSessionTaskDelegate *delegate = [[PKTURLSessionTaskDelegate alloc] initWithRequest:request
                                                                   responseProcessingQueue:self.processingQueue
                                                                             progressBlock:nil
                                                                      responseProcessBlock:nil
                                                                           completionBlock:^(PKTResponse *response, NSError *error) {
      occurredError = error;
  }];
  
  NSURLSessionDataTask *mockTask = [[self class] mockTaskWithResponseStatusCode:400];
  [delegate task:mockTask didCompleteWithError:nil];
  
  expect(occurredError).willNot.beNil();
}

- (void)testCompletionWithClientError {
  __block NSError *occurredError = nil;
  
  PKTRequest *request = [PKTRequest GETRequestWithPath:@"/some/path" parameters:nil];
  PKTURLSessionTaskDelegate *delegate = [[PKTURLSessionTaskDelegate alloc] initWithRequest:request
                                                                   responseProcessingQueue:self.processingQueue
                                                                             progressBlock:nil
                                                                      responseProcessBlock:nil
                                                                           completionBlock:^(PKTResponse *response, NSError *error) {
     occurredError = error;
  }];
  
  // Successful task
  NSURLSessionDataTask *mockTask = [[self class] mockTaskWithResponseStatusCode:200];
  
  // Trigger a client error before the task completes, e.g. when a file could not be moved
  NSError *error = [NSError errorWithDomain:@"SomeDomain" code:0 userInfo:nil];
  [delegate task:mockTask didError:error];
  
  // Complete without error
  [delegate task:mockTask didCompleteWithError:nil];
  
  expect(occurredError).willNot.beNil();
}

- (void)testTaskDidFinishDownloadingToURL {
  __block NSError *occurredError = nil;

  NSString *directoryPath = NSTemporaryDirectory();
  NSString *fromFilePath = [directoryPath stringByAppendingPathComponent:@"test_from_file"];
  NSString *toFilePath = [directoryPath stringByAppendingPathComponent:@"test_to_file"];
  
  // Create a file at first location
  NSDictionary *someData = @{@"key": @"value"};
  [someData writeToFile:fromFilePath atomically:YES];
  
  PKTRequest *request = [PKTRequest GETRequestWithPath:@"/some/path" parameters:nil];
  request.fileData = [PKTRequestFileData fileDataWithFilePath:toFilePath name:nil fileName:nil];
  
  PKTURLSessionTaskDelegate *delegate = [[PKTURLSessionTaskDelegate alloc] initWithRequest:request
                                                                   responseProcessingQueue:self.processingQueue
                                                                             progressBlock:nil
                                                                      responseProcessBlock:nil
                                                                           completionBlock:^(PKTResponse *response, NSError *error) {
                                                                             occurredError = error;
                                                                           }];
  
  // Successful task
  NSURLSessionDataTask *mockTask = [[self class] mockTaskWithResponseStatusCode:200];
  
  // Indicate that the file has been downloaded to a certain location
  [delegate task:mockTask didFinishDownloadingToURL:[NSURL fileURLWithPath:fromFilePath]];
  
  // Complete without error
  [delegate task:mockTask didCompleteWithError:nil];
  
  // Expect the file to have been moved to the location specified by the request fileData object
  BOOL existsAtNewLocation = [[NSFileManager defaultManager] fileExistsAtPath:toFilePath];
  expect(existsAtNewLocation).to.beTruthy();
  
  // Cleanup
  if (existsAtNewLocation) {
    [[NSFileManager defaultManager] removeItemAtPath:fromFilePath error:nil];
    [[NSFileManager defaultManager] removeItemAtPath:toFilePath error:nil];
  }
}

- (void)testTaskDidReceiveData {
  __block PKTResponse *receivedResponse = nil;
  NSMutableArray *progressUpdates = [NSMutableArray new];
  
  PKTRequest *request = [PKTRequest GETRequestWithPath:@"/some/path" parameters:nil];
  PKTURLSessionTaskDelegate *delegate = [[PKTURLSessionTaskDelegate alloc] initWithRequest:request
                                                                   responseProcessingQueue:self.processingQueue
                                                                             progressBlock:^(float progress, int64_t totalBytesExpected, int64_t totalBytesReceived) {
    [progressUpdates addObject:@(progress)];
  }
                                                                      responseProcessBlock:nil
                                                                           completionBlock:^(PKTResponse *response, NSError *error) {
    receivedResponse = response;
  }];
  
  NSURLSessionDataTask *mockTask = [[self class] mockTaskWithResponseStatusCode:200];
  
  // Indicate that some data was received
  NSData *data = [@"SomeString" dataUsingEncoding:NSUTF8StringEncoding];
  [delegate task:mockTask didReceiveData:data];
  
  // Complete the task
  [delegate task:mockTask didCompleteWithError:nil];
  
  expect(receivedResponse.body).will.equal(data);
  expect(progressUpdates).will.haveCountOf(1);
}

- (void)testTaskDidUpdateProgress {
  NSMutableArray *progressUpdates = [NSMutableArray new];
  
  PKTRequest *request = [PKTRequest GETRequestWithPath:@"/some/path" parameters:nil];
  PKTURLSessionTaskDelegate *delegate = [[PKTURLSessionTaskDelegate alloc] initWithRequest:request
                                                                   responseProcessingQueue:self.processingQueue
                                                                             progressBlock:^(float progress, int64_t totalBytesExpected, int64_t totalBytesReceived) {
    [progressUpdates addObject:@(progress)];
  } responseProcessBlock:nil completionBlock:nil];
  
  [delegate taskDidUpdateProgress:nil];
  [delegate taskDidUpdateProgress:nil];
  
  expect(progressUpdates).will.haveCountOf(2);
}

#pragma mark - Helpers

+ (NSURLSessionDataTask *)mockTaskWithResponseStatusCode:(NSInteger)statusCode {
  id mockTask = [OCMockObject niceMockForClass:[NSURLSessionDataTask class]];
  
  NSURL *url = [NSURL URLWithString:@"https://api.podio.com/something"];
  NSHTTPURLResponse *response = [[NSHTTPURLResponse alloc] initWithURL:url statusCode:statusCode HTTPVersion:@"HTTP/1.1" headerFields:nil];
  [[[mockTask expect] andReturn:response] response];
  
  return mockTask;
}

@end
