//
//  PKTPushCredential.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTPushCredential.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTPushCredential

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{ @"expiresOn": @"expires_in" };
}

+ (NSValueTransformer *)expiresOnValueTransformer {
  return [NSValueTransformer pkt_transformerWithBlock:^id(NSNumber *expiresIn) {
    return [NSDate dateWithTimeIntervalSinceNow:[expiresIn doubleValue]];
  }];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  // Since this object is immutable, just return the same instance
  return self;
}

@end
