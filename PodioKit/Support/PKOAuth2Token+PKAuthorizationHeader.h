//
//  PKOAuth2Token+PKAuthorizationHeader.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 13/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKOAuth2Token.h"

@interface PKOAuth2Token (PKAuthorizationHeader)

- (NSString *)pk_authorizationHeaderValue;

@end
