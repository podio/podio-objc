//
//  NSMutableURLRequest+PKTHeaders.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 21/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSMutableURLRequest+PKTHeaders.h"
#import "NSString+PKTBase64.h"

static NSString * const kHeaderAuthorization = @"Authorization";
static NSString * const kAuthorizationOAuth2AccessTokenFormat = @"OAuth2 %@";

@implementation NSMutableURLRequest (PKTHeaders)

- (void)pkt_setAuthorizationHeaderWithOAuth2AccessToken:(NSString *)accessToken {
  NSString *value = [NSString stringWithFormat:kAuthorizationOAuth2AccessTokenFormat, accessToken];
  [self setValue:value forHTTPHeaderField:kHeaderAuthorization];
}

- (void)pkt_setAuthorizationHeaderWithUsername:(NSString *)username password:(NSString *)password {
  NSString *authString = [NSString stringWithFormat:@"%@:%@", username, password];
  [self setValue:[NSString stringWithFormat:@"Basic %@", [authString pkt_base64String]] forHTTPHeaderField:@"Authorization"];
}

@end
