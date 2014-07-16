//
//  PKTRequestSerializer.h
//  PodioKit
//
//  Created by Romain Briche on 22/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

@class PKTRequest;

@class PKTMultipartFormData;

@interface PKTRequestSerializer : NSObject

@property (nonatomic, copy, readonly) NSDictionary *additionalHTTPHeaders;

- (NSMutableURLRequest *)URLRequestForRequest:(PKTRequest *)request relativeToURL:(NSURL *)baseURL;
- (NSMutableURLRequest *)URLRequestForRequest:(PKTRequest *)request multipartData:(PKTMultipartFormData *)multipartData relativeToURL:(NSURL *)baseURL;

- (void)setValue:(NSString *)value forHTTPHeader:(NSString *)header;
- (void)setAuthorizationHeaderWithOAuth2AccessToken:(NSString *)accessToken;
- (void)setAuthorizationHeaderWithAPIKey:(NSString *)key secret:(NSString *)secret;

- (PKTMultipartFormData *)multipartFormDataFromRequest:(PKTRequest *)request;

@end
