//
//  NSError+PKErrors.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/14/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString * const PKPodioKitErrorDomain;
extern NSString * const PKErrorStatusCodeKey;
extern NSString * const PKErrorResponseDataKey;
extern NSString * const PKErrorPropagateKey;
extern NSString * const PKErrorErrorIdKey;

@interface NSError (PKErrors)

+ (NSError *)pk_noConnectionError;
+ (NSError *)pk_notAuthenticatedError;
+ (NSError *)pk_requestCancelledError;
+ (NSError *)pk_responseParseError;
+ (NSError *)pk_serverErrorWithStatusCode:(NSUInteger)statusCode parsedData:(id)parsedData;

- (NSString *)pk_serverSideDescription;
- (NSString *)pk_humanServerSideDescription;
- (NSString *)pk_serverSideErrorId;
- (BOOL)pk_isServerSideErrorWithId:(NSString *)errorId;

@end
