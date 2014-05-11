//
//  PKTFileAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTFileAPI.h"

@interface PKTFileAPITests : XCTestCase

@end

@implementation PKTFileAPITests

- (void)testRequestForFileUploadWithData {
  NSData *data = [NSData data];
  PKTRequest *request = [PKTFileAPI requestToUploadFileWithData:data fileName:@"image.jpg" mimeType:@"image/jpeg"];
  
  expect(request.path).to.equal(@"/file/");
  expect(request.contentType).to.equal(PKTRequestContentTypeMultipart);
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.parameters[@"filename"]).to.equal(@"image.jpg");
  expect(request.fileData.data).to.equal(data);
  expect(request.fileData.name).to.equal(@"source");
  expect(request.fileData.fileName).to.equal(@"image.jpg");
  expect(request.fileData.mimeType).to.equal(@"image/jpeg");
}

- (void)testRequestForFileUploadWithFileURL {
  NSURL *url = [NSURL URLWithString:@"file://some/local/folder/image.jpg"];
  PKTRequest *request = [PKTFileAPI requestToUploadFileWithURL:url fileName:@"image.jpg" mimeType:@"image/jpeg"];
  
  expect(request.path).to.equal(@"/file/");
  expect(request.contentType).to.equal(PKTRequestContentTypeMultipart);
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.parameters[@"filename"]).to.equal(@"image.jpg");
  expect(request.fileData.fileURL).to.equal(url);
  expect(request.fileData.name).to.equal(@"source");
  expect(request.fileData.fileName).to.equal(@"image.jpg");
  expect(request.fileData.mimeType).to.equal(@"image/jpeg");
}

- (void)testRequestToAttachFile {
  PKTRequest *request = [PKTFileAPI requestToAttachFileWithID:123 referenceID:333 referenceType:PKTReferenceTypeItem];
  
  expect(request.path).to.equal(@"/file/123/attach");
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.parameters[@"ref_type"]).to.equal(@"item");
  expect(request.parameters[@"ref_id"]).to.equal(@333);
}

@end
