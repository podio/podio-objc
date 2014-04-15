//
//  PKTResponse.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTResponse.h"

@implementation PKTResponse

@synthesize stringData = _stringData;
@synthesize parsedData = _parsedData;

- (instancetype)initWithData:(NSData *)data {
  self = [super init];
  if (!self) return nil;
  
  _data = data;
  
  return self;
}

#pragma mark - Properties

- (NSString *)stringData {
  if (!_stringData) {
    _stringData = [[NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
  }
  
  return _stringData;
}

- (id)parsedData {
  if (!_parsedData) {
    _parsedData = [NSJSONSerialization JSONObjectWithData:self.data options:0 error:nil];
  }
  
  return _parsedData;
}

@end
