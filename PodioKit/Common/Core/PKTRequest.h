//
//  PKTRequest.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTRequestFileData.h"

#define PKTRequestPath(fmt, ...) [NSString stringWithFormat:fmt, ##__VA_ARGS__]

typedef NSURLRequest * (^PKTURLRequestConfigurationBlock) (NSURLRequest *request);

typedef NS_ENUM(NSUInteger, PKTRequestMethod) {
  PKTRequestMethodGET = 0,
  PKTRequestMethodPOST,
  PKTRequestMethodPUT,
  PKTRequestMethodDELETE,
  PKTRequestMethodHEAD,
};

typedef NS_ENUM(NSUInteger, PKTRequestContentType) {
  PKTRequestContentTypeJSON = 0,
  PKTRequestContentTypeFormURLEncoded,
  PKTRequestContentTypeMultipart
};

@interface PKTRequest : NSObject

@property (nonatomic, assign, readonly) PKTRequestMethod method;
@property (nonatomic, copy, readonly) NSString *path;
@property (nonatomic, copy, readonly) NSURL *URL;
@property (nonatomic, copy, readonly) NSDictionary *parameters;
@property (nonatomic, strong) PKTRequestFileData *fileData;
@property (nonatomic, assign, readwrite) PKTRequestContentType contentType;
@property (nonatomic, copy, readwrite) PKTURLRequestConfigurationBlock URLRequestConfigurationBlock;

+ (instancetype)GETRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters;
+ (instancetype)POSTRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters;
+ (instancetype)PUTRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters;
+ (instancetype)DELETERequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters;

+ (instancetype)GETRequestWithURL:(NSURL *)url parameters:(NSDictionary *)parameters;
+ (instancetype)POSTRequestWithURL:(NSURL *)url parameters:(NSDictionary *)parameters;
+ (instancetype)PUTRequestWithURL:(NSURL *)url parameters:(NSDictionary *)parameters;
+ (instancetype)DELETERequestWithURL:(NSURL *)url parameters:(NSDictionary *)parameters;

@end
