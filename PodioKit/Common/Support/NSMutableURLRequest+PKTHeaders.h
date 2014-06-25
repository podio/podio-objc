//
//  NSMutableURLRequest+PKTHeaders.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 21/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (PKTHeaders)

- (void)pkt_setAuthorizationHeaderWithOAuth2AccessToken:(NSString *)accessToken;
- (void)pkt_setAuthorizationHeaderWithUsername:(NSString *)username password:(NSString *)password;

@end
