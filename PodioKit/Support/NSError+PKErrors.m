//
//  NSError+PKErrors.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/14/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "NSError+PKErrors.h"


NSString * const PKErrorStatusCodeKey = @"PKErrorStatusCodeKey";
NSString * const PKERrorResponseStringKey = @"PKERrorResponseStringKey";

@implementation NSError (PKErrors)

+ (NSError *)pk_noConnectionError {
  NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
  [userInfo setObject:NSLocalizedString(@"You are not connected to the internet, please try again later.", nil) forKey:NSLocalizedDescriptionKey];
  
  return [NSError errorWithDomain:kPodioKitErrorDomain code:PKErrorCodeNoConnection userInfo:userInfo];
}

+ (NSError *)pk_notAuthenticatedError {
  NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
  [userInfo setObject:NSLocalizedString(@"You are not logged in.", nil) forKey:NSLocalizedDescriptionKey];
  
  return [NSError errorWithDomain:kPodioKitErrorDomain code:PKErrorCodeNotAuthenticated userInfo:userInfo];
}

+ (NSError *)pk_requestCancelledError {
  NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
  [userInfo setObject:NSLocalizedString(@"The request was cancelled.", nil) forKey:NSLocalizedDescriptionKey];
  
  return [NSError errorWithDomain:kPodioKitErrorDomain code:PKErrorCodeRequestCancelled userInfo:userInfo];
}

+ (NSError *)pk_responseParseError {
  NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
  [userInfo setObject:NSLocalizedString(@"Unable to read the server response.", nil) forKey:NSLocalizedDescriptionKey];
  
  return [NSError errorWithDomain:kPodioKitErrorDomain code:PKErrorCodeParsingFailed userInfo:userInfo];
}

+ (NSError *)pk_serverErrorWithStatusCode:(NSUInteger)statusCode responseString:(NSString *)responseString {
  NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
  [userInfo setObject:NSLocalizedString(@"A server error occurred.", nil) forKey:NSLocalizedDescriptionKey];
  [userInfo setObject:[NSNumber numberWithUnsignedInteger:statusCode] forKey:PKErrorStatusCodeKey];
  [userInfo setObject:responseString forKey:PKERrorResponseStringKey];
  
  return [NSError errorWithDomain:kPodioKitErrorDomain code:PKErrorCodeServerError userInfo:userInfo];
}

@end
