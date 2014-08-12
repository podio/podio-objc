//
//  NSError+PKTErrors.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const PodioServerErrorDomain;

extern NSString * const PKTErrorKey;
extern NSString * const PKTErrorDescriptionKey;
extern NSString * const PKTErrorDetailKey;
extern NSString * const PKTErrorParametersKey;
extern NSString * const PKTErrorPropagateKey;

@interface NSError (PKTErrors)

+ (NSError *)pkt_serverErrorWithStatusCode:(NSUInteger)statusCode body:(id)body;

- (BOOL)pkt_isServerError;

@end
