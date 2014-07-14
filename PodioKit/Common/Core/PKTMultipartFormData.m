//
//  PKTMultipartFormData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTMultipartFormData.h"
#import "NSString+PKTRandom.h"
#import "NSDictionary+PKTQueryParameters.h"

@interface PKTMultipartFormData ()

@property (nonatomic, copy, readonly) NSString *boundary;
@property (nonatomic, readonly) NSStringEncoding encoding;
@property (nonatomic, strong, readonly) NSMutableData *data;
@property (nonatomic, strong, readonly) NSMutableString *dataString;

@end

@implementation PKTMultipartFormData

@synthesize boundary = _boundary;
@synthesize data = _data;
@synthesize dataString = _dataString;
@synthesize finalizedData = _finalizedData;

- (instancetype)init {
  return [self initWithBoundary:nil encoding:NSUTF8StringEncoding];
}

- (instancetype)initWithBoundary:(NSString *)boundary encoding:(NSStringEncoding)encoding {
  NSParameterAssert(boundary);
  
  self = [super init];
  if (!self) return nil;
  
  _boundary = [boundary copy];
  _encoding = encoding;
  
  return self;
}

+ (instancetype)multipartFormDataWithBoundary:(NSString *)boundary encoding:(NSStringEncoding)encoding {
  return [[self alloc] initWithBoundary:boundary encoding:encoding];
}

- (NSMutableData *)data {
  if (!_data) {
    _data = [NSMutableData data];
  }
  
  return _data;
}

- (NSMutableString *)dataString {
  if (!_dataString) {
    _dataString = [NSMutableString new];
  }
  
  return _dataString;
}

- (NSString *)stringRepresentation {
  return [self.dataString copy];
}

#pragma mark - Private

- (void)appendStringAsData:(NSString *)string {
  [self.data appendData:[string dataUsingEncoding:self.encoding]];
  [self.dataString appendString:string];
}

- (void)appendData:(NSData *)data {
  [self.data appendData:data];
  [self.dataString appendString:data.description];
}

- (void)appendData:(NSData *)data withHeaders:(NSArray *)headers {
  NSAssert(_finalizedData == nil, @"You cannot append more data after finalizing.");
  
  [self appendBoundary];
  
  for (NSString *header in headers) {
    [self appendStringAsData:[NSString stringWithFormat:@"\r\n%@", header]];
  }
  
  // Required new lines before content
  [self appendStringAsData:@"\r\n\r\n"];
  
  // Append content
  [self appendData:data];
}

- (void)appendBoundary {
  [self appendBoundaryFinal:NO];
}
- (void)appendFinalBoundary {
  [self appendBoundaryFinal:YES];
}

- (void)appendBoundaryFinal:(BOOL)isFinal {
  NSString *boundaryString = [NSString stringWithFormat:@"--%@", self.boundary];
  if ([self.data length] > 0) {
    // Not inital boundary, add newline before
    boundaryString = [NSString stringWithFormat:@"\r\n%@", boundaryString];
  }
  
  if (isFinal) {
    boundaryString = [boundaryString stringByAppendingString:@"--"];
  }
  
  [self appendStringAsData:boundaryString];
}

#pragma mark - Public

- (void)appendFileData:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mimeType name:(NSString *)name {
  NSArray *headers = @[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"", name, fileName],
                        [NSString stringWithFormat:@"Content-Type: %@", (mimeType ?: @"application/octet-stream")]];
  [self appendData:data withHeaders:headers];
}

- (void)appendFormDataParameters:(NSDictionary *)parameters {
  NSDictionary *queryParameters = [parameters pkt_queryParametersPairs];
  
  [queryParameters enumerateKeysAndObjectsUsingBlock:^(NSString *name, NSString *value, BOOL *stop) {
    NSString *header = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"", name];
    [self appendData:[value dataUsingEncoding:self.encoding] withHeaders:@[header]];
  }];
}

- (void)finalizeData {
  if (!_finalizedData) {
    [self appendFinalBoundary];
    _finalizedData = [NSData dataWithData:self.data];
  }
}

- (NSData *)finalizedData {
  [self finalizeData];
  return _finalizedData;
}

@end
