//
//  PKTMultipartFormDataTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTMultipartFormData.h"

static NSString * const kBoundary = @"--------------45ab933bef";

@interface PKTMultipartFormDataTests : XCTestCase

@end

@implementation PKTMultipartFormDataTests

- (void)testGeneratesNonDataForBinary {
  PKTMultipartFormData *multiPartData = [PKTMultipartFormData multipartFormDataWithBoundary:kBoundary encoding:NSUTF8StringEncoding];
  
  NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"Podio" ofType:@"png"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  [multiPartData appendFileData:data fileName:@"Podio.png" mimeType:nil name:@"source"];
  
  [multiPartData finalizeData];
  
  expect(multiPartData.finalizedData).notTo.beNil();
  expect([multiPartData.finalizedData length]).to.beGreaterThan(data.length);
  expect(multiPartData.stringRepresentation).to.contain(@"Content-Disposition: form-data; name=\"source\"; filename=\"Podio.png\"");
  expect(multiPartData.stringRepresentation).to.contain(@"Content-Type: application/octet-stream");
}

- (void)testGeneratesNonDataForFormData {
  NSDictionary *params = @{@"param1" : @"value1", @"param2" : @"value2" };
  
  PKTMultipartFormData *multiPartData = [PKTMultipartFormData multipartFormDataWithBoundary:kBoundary encoding:NSUTF8StringEncoding];
  [multiPartData appendFormDataParameters:params];
  [multiPartData finalizeData];
  
  expect(multiPartData.finalizedData).notTo.beNil();
  expect([multiPartData.finalizedData length]).to.beGreaterThan(0);
  expect(multiPartData.stringRepresentation).to.contain(@"Content-Disposition: form-data; name=\"param1\"");
  expect(multiPartData.stringRepresentation).to.contain(@"Content-Disposition: form-data; name=\"param2\"");
}

@end
