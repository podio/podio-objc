//
//  PKTRequestSerializer.h
//  PodioKit
//
//  Created by Romain Briche on 22/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

@class PKTRequest;

@class PKTMultipartFormData;

extern NSString * const PKTRequestSerializerHTTPHeaderKeyAuthorization;
extern NSString * const PKTRequestSerializerHTTPHeaderKeyUserAgent;
extern NSString * const PKTRequestSerializerHTTPHeaderKeyContentType;
extern NSString * const PKTRequestSerializerHTTPHeaderKeyContentLength;

@interface PKTRequestSerializer : NSObject

- (NSMutableURLRequest *)URLRequestForRequest:(PKTRequest *)request relativeToURL:(NSURL *)baseURL;
- (NSMutableURLRequest *)URLRequestForRequest:(PKTRequest *)request multipartData:(PKTMultipartFormData *)multipartData relativeToURL:(NSURL *)baseURL;

- (id)valueForHTTPHeader:(NSString *)header;

- (void)setValue:(NSString *)value forHTTPHeader:(NSString *)header;
- (void)setAuthorizationHeaderWithOAuth2AccessToken:(NSString *)accessToken;
- (void)setAuthorizationHeaderWithAPIKey:(NSString *)key secret:(NSString *)secret;
- (void)setUserAgentHeader:(NSString *)userAgent;

- (PKTMultipartFormData *)multipartFormDataFromRequest:(PKTRequest *)request;

@end
