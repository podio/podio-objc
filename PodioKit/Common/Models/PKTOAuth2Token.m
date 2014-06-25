//
//  PKTOAuth2Token.m
//  PodioKit
//
//  Created by Romain Briche on 28/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTOAuth2Token.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTOAuth2Token

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
  if (![object isKindOfClass:[self class]]) return NO;
  
  return [self.accessToken isEqualToString:[object accessToken]];
}

- (NSUInteger)hash {
  return [self.accessToken hash];
}

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"accessToken": @"access_token",
    @"refreshToken": @"refresh_token",
    @"expiresOn": @"expires_in",
    @"refData": @"ref",
  };
}

+ (NSValueTransformer *)expiresOnValueTransformer {
  return [NSValueTransformer pkt_transformerWithBlock:^id(NSNumber *expiresIn) {
    return [NSDate dateWithTimeIntervalSinceNow:[expiresIn doubleValue]];
  }];
}

#pragma mark - Public

- (BOOL)willExpireWithinIntervalFromNow:(NSTimeInterval)expireInterval {
  NSDate *date = [NSDate dateWithTimeIntervalSinceNow:expireInterval];
  return [self.expiresOn earlierDate:date] == self.expiresOn;
}

@end
