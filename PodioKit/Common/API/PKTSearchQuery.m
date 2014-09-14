//
//  PKTSearchQuery.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTSearchQuery.h"
#import "NSValueTransformer+PKTConstants.h"

@implementation PKTSearchQuery

- (instancetype)init {
  return [self initWithText:nil];
}

- (instancetype)initWithText:(NSString *)text {
  NSParameterAssert(text);
  
  self = [super init];
  if (!self) return nil;
  
  _text = [text copy];
  _returnCounts = YES;
  
  return self;
}

+ (instancetype)queryWithText:(NSString *)text {
  return [[self alloc] initWithText:text];
}

#pragma mark - PKTRequestParameters

- (NSDictionary *)queryParameters {
  NSParameterAssert(self.text);
  
  NSMutableDictionary *params = [NSMutableDictionary new];
  
  params[@"query"] = self.text;
  params[@"counts"] = @(self.returnCounts);
  
  if (self.referenceType != PKTReferenceTypeUnknown) {
    params[@"ref_type"] = [NSValueTransformer pkt_stringFromReferenceType:self.referenceType];
  }
  
  return [params copy];
}

@end
