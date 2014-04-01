//
//  PKTRequest.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PKTRequestPath(fmt, ...) [NSString stringWithFormat:fmt, ##__VA_ARGS__]

typedef NS_ENUM(NSUInteger, PKTRequestMethod) {
  PKTRequestMethodGET = 0,
  PKTRequestMethodPOST,
  PKTRequestMethodPUT,
  PKTRequestMethodDELETE,
};

@interface PKTRequest : NSObject

@property (nonatomic, assign, readonly) PKTRequestMethod method;
@property (nonatomic, copy, readonly) NSString *path;
@property (nonatomic, copy, readonly) NSDictionary *parameters;
@property (nonatomic, strong) id body;

+ (instancetype)GETRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters;
+ (instancetype)POSTRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters;
+ (instancetype)PUTRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters;
+ (instancetype)DELETERequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters;

@end
