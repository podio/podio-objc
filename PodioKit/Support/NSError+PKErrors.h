//
//  NSError+PKErrors.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/14/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString * const PKErrorStatusCodeKey;
extern NSString * const PKERrorResponseStringKey;

@interface NSError (PKErrors)

+ (NSError *)pk_noConnectionError;
+ (NSError *)pk_notAuthenticatedError;
+ (NSError *)pk_requestCancelledError;
+ (NSError *)pk_responseParseError;
+ (NSError *)pk_serverErrorWithStatusCode:(NSUInteger)statusCode responseString:(NSString *)responseString;

@end
