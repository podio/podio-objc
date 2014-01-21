//
//  PKTRequest.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PKTRequestMethod) {
  PKTRequestMethodGET,
  PKTRequestMethodPOST,
  PKTRequestMethodPUT,
  PKTRequestMethodDELETE,
};

@interface PKTRequest : NSObject

@property (nonatomic, assign, readonly) PKTRequestMethod method;
@property (nonatomic, copy, readonly) NSString *path;
@property (nonatomic, copy, readonly) NSDictionary *parameters;

+ (instancetype)GETRequestWithPath:(NSString *)path;
+ (instancetype)POSTRequestWithPath:(NSString *)path;
+ (instancetype)PUTRequestWithPath:(NSString *)path;
+ (instancetype)DELETERequestWithPath:(NSString *)path;

@end
