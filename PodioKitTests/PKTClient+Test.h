//
//  PKTClient+Test.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 21/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

@interface PKTClient (Test)

+ (NSString *)HTTPMethodForMethod:(PKTRequestMethod)method;

- (NSURLRequest *)URLRequestForRequest:(PKTRequest *)request;

@end