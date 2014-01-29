//
//  PKTRequest.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PKTRequestMethod) {
  PKTRequestMethodGET = 0,
  PKTRequestMethodPOST,
  PKTRequestMethodPUT,
  PKTRequestMethodDELETE,
};

typedef NS_ENUM(NSUInteger, PKTRequestAuthorizationType) {
  PKTRequestAuthorizationTypeNone = 0,
  PKTRequestAuthorizationTypeAPIKeys,
  PKTRequestAuthorizationTypeOAuthToken,
};

@interface PKTRequest : NSObject

@property (nonatomic, assign, readonly) PKTRequestMethod method;
@property (nonatomic, copy, readonly) NSString *path;
@property (nonatomic, copy, readonly) NSDictionary *parameters;
@property (nonatomic, assign) PKTRequestAuthorizationType authorizationType;

+ (instancetype)GETRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters;
+ (instancetype)POSTRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters;
+ (instancetype)PUTRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters;
+ (instancetype)DELETERequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters;

@end
