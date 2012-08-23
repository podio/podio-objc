//
//  PKRequestResult.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/14/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKRequestResult.h"
#import "JSONKit.h"

@implementation PKRequestResult

@synthesize responseStatusCode = responseStatusCode_;
@synthesize responseString = responseString_;
@synthesize responseData = responseData_;
@synthesize parsedData = parsedData_;
@synthesize objectData = objectData_;
@synthesize resultData = resultData_;
@synthesize responseObjectCount = responseObjectCount_;

- (id)initWithResponseStatusCode:(NSUInteger)responseStatusCode responseData:(id)responseData parsedData:(id)parsedData objectData:(id)objectData resultData:(id)resultData {
  self = [super init];
  if (self) {
    responseStatusCode_ = responseStatusCode;
    responseData_ = responseData;
    parsedData_ = parsedData;
    resultData_ = resultData;
    objectData_ = objectData;
    responseString_ = nil;
    responseObjectCount_ = -1;
  }
  return self;
}

+ (PKRequestResult *)resultWithResponseStatusCode:(NSUInteger)responseStatusCode responseData:(id)responseData parsedData:(id)parsedData objectData:(id)objectData resultData:(id)resultData {
  return [[self alloc] initWithResponseStatusCode:responseStatusCode responseData:responseData parsedData:parsedData objectData:objectData resultData:resultData];
}

// Lazy evaluate
- (NSString *)responseString {
  if (responseString_ == nil) {
    responseString_ = [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
  }
  
  return [responseString_ copy];
}

- (NSInteger)responseObjectCount {
  if (responseObjectCount_ == -1) {
    if (self.objectData != nil) {
      responseObjectCount_ = [self.objectData isKindOfClass:[NSArray class]] ? [self.objectData count] : 1; 
    } else {
      responseObjectCount_ = 0;
    }
  }
  
  return responseObjectCount_;
}

@end
