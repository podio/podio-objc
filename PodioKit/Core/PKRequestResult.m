//
//  PKRequestResult.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/14/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKRequestResult.h"
#import "JSONKit.h"

@implementation PKRequestResult

@synthesize responseStatusCode = responseStatusCode_;
@synthesize responseData = responseData_;
@synthesize parsedData = parsedData_;
@synthesize resultData = resultData_;

- (id)initWithResponseStatusCode:(NSUInteger)responseStatusCode responseData:(id)responseData parsedData:(id)parsedData resultData:(id)resultData {
  self = [super init];
  if (self) {
    responseStatusCode_ = responseStatusCode;
    responseData_ = responseData;
    parsedData_ = parsedData;
    resultData_ = resultData;
    responseString_ = nil;
    responseObjectCount_ = -1;
  }
  return self;
}

+ (PKRequestResult *)resultWithResponseStatusCode:(NSUInteger)responseStatusCode responseData:(id)responseData parsedData:(id)parsedData resultData:(id)resultData {
  return [[self alloc] initWithResponseStatusCode:responseStatusCode responseData:responseData parsedData:parsedData resultData:resultData];
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
    if (self.parsedData != nil) {
      responseObjectCount_ = [self.parsedData isKindOfClass:[NSArray class]] ? [self.parsedData count] : 1; 
    } else {
      responseObjectCount_ = 0;
    }
  }
  
  return responseObjectCount_;
}

@end
