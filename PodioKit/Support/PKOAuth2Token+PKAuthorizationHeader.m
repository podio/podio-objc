//
//  PKOAuth2Token+PKAuthorizationHeader.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 13/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKOAuth2Token+PKAuthorizationHeader.h"

@implementation PKOAuth2Token (PKAuthorizationHeader)

- (NSString *)pk_authorizationHeaderValue {
  return [NSString stringWithFormat:@"OAuth2 %@", self.accessToken];
}

@end
