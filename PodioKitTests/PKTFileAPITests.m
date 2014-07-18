//
//  PKTFileAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTFilesAPI.h"

@interface PKTFileAPITests : XCTestCase

@end

@implementation PKTFileAPITests

- (void)testRequestToDownloadFile {
  NSURL *fileURL = [NSURL URLWithString:@"https://files.podio.com/11111"];
  PKTRequest *request = [PKTFilesAPI requestToDownloadFileWithURL:fileURL];
  
  expect(request.URL).to.equal(fileURL);
  expect(request.method).to.equal(PKTRequestMethodGET);
  expect(request.fileData).to.beNil();
}

- (void)testRequestToDownloadFileToLocalFile {
  NSURL *fileURL = [NSURL URLWithString:@"https://files.podio.com/11111"];
  NSString *path = @"/tmp/file.pdf";
  PKTRequest *request = [PKTFilesAPI requestToDownloadFileWithURL:fileURL toLocalFileWithPath:path];
  
  expect(request.URL).to.equal(fileURL);
  expect(request.method).to.equal(PKTRequestMethodGET);
  expect(request.fileData.filePath).to.equal(path);
}

- (void)testRequestForFileUploadWithData {
  NSData *data = [NSData data];
  PKTRequest *request = [PKTFilesAPI requestToUploadFileWithData:data fileName:@"image.jpg"];
  
  expect(request.path).to.equal(@"/file/");
  expect(request.contentType).to.equal(PKTRequestContentTypeMultipart);
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.parameters[@"filename"]).to.equal(@"image.jpg");
  expect(request.fileData.data).to.equal(data);
  expect(request.fileData.name).to.equal(@"source");
  expect(request.fileData.fileName).to.equal(@"image.jpg");
}

- (void)testRequestForFileUploadWithFileURL {
  NSString *path = @"/some/local/folder/image.jpg";
  PKTRequest *request = [PKTFilesAPI requestToUploadFileWithPath:path fileName:@"image.jpg"];
  
  expect(request.path).to.equal(@"/file/");
  expect(request.contentType).to.equal(PKTRequestContentTypeMultipart);
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.parameters[@"filename"]).to.equal(@"image.jpg");
  expect(request.fileData.filePath).to.equal(path);
  expect(request.fileData.name).to.equal(@"source");
  expect(request.fileData.fileName).to.equal(@"image.jpg");
}

- (void)testRequestToAttachFile {
  PKTRequest *request = [PKTFilesAPI requestToAttachFileWithID:123 referenceID:333 referenceType:PKTReferenceTypeItem];
  
  expect(request.path).to.equal(@"/file/123/attach");
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.parameters[@"ref_type"]).to.equal(@"item");
  expect(request.parameters[@"ref_id"]).to.equal(@333);
}

@end
