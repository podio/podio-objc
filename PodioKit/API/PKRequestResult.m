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
    responseData_ = [responseData retain];
    parsedData_ = [parsedData retain];
    resultData_ = [resultData retain];
    responseString_ = nil;
    responseObjectCount_ = -1;
  }
  return self;
}

- (void)dealloc {
  [responseString_ release], responseString_ = nil;
  [responseData_ release], responseData_ = nil;
  [parsedData_ release], parsedData_ = nil;
  [resultData_ release], resultData_ = nil;
  [super dealloc];
}

+ (PKRequestResult *)resultWithResponseStatusCode:(NSUInteger)responseStatusCode responseData:(id)responseData parsedData:(id)parsedData resultData:(id)resultData {
  return [[[self alloc] initWithResponseStatusCode:responseStatusCode responseData:responseData parsedData:parsedData resultData:resultData] autorelease];
}

// Lazy evaluate
- (NSString *)responseString {
  if (responseString_ == nil) {
    responseString_ = [[self.responseData JSONStringWithOptions:JKParseOptionLooseUnicode error:nil] copy];
  }
  
  return [[responseString_ copy] autorelease];
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
