//
//  PKTResponse.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKTResponse : NSObject

@property (nonatomic, assign, readonly) NSInteger statusCode;
@property (nonatomic, copy, readonly) id body;

- (instancetype)initWithStatusCode:(NSInteger)statusCode body:(id)body;

@end
