//
//  PKAPIResponse.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-01.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKAPIResponse.h"
#import "JSONKit.h"


@implementation PKAPIResponse

@synthesize responseData = responseData_;
@synthesize error = error_;

- (id)initWithData:(NSData *)data {
  self = [super init];
  if (self) {
    responseData_ = data;
    self.error = nil;
  }
  return self;
}


+ (id)responseWithData:(NSData *)data {
  return [[self alloc] initWithData:data];
}

#pragma mark - Impl

- (NSString *)responseString {
  return [[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding];
}

- (id)responseObjectFromJSON {
  NSError *error = nil;
  id obj = [self.responseData objectFromJSONDataWithParseOptions:(JKParseOptionLooseUnicode) 
                                                           error:&error];
  if (error != nil) {
    obj = nil;
    NSLog(@"ERROR: Failed to parse object from JSON data: %@", self.responseString);
  }
  
  return obj;
}

@end
