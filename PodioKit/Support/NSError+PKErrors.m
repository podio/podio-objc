//
//  NSError+PKErrors.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/14/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "NSError+PKErrors.h"
#import "NSDictionary+PKAdditions.h"


NSString * const PKPodioKitErrorDomain = @"PodioKitErrorDomain";
NSString * const PKErrorStatusCodeKey = @"PKErrorStatusCodeKey";
NSString * const PKErrorResponseDataKey = @"PKErrorResponseDataKey";
NSString * const PKErrorPropagateKey = @"PKErrorPropagateKey";
NSString * const PKErrorErrorIdKey = @"PKErrorErrorIdKey";

@implementation NSError (PKErrors)

+ (NSError *)pk_noConnectionError {
  NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
  [userInfo setObject:NSLocalizedString(@"You are not connected to the internet, please try again later.", nil) forKey:NSLocalizedDescriptionKey];
  
  return [NSError errorWithDomain:PKPodioKitErrorDomain code:PKErrorCodeNoConnection userInfo:userInfo];
}

+ (NSError *)pk_notAuthenticatedError {
  NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
  [userInfo setObject:NSLocalizedString(@"You are not logged in.", nil) forKey:NSLocalizedDescriptionKey];
  
  return [NSError errorWithDomain:PKPodioKitErrorDomain code:PKErrorCodeNotAuthenticated userInfo:userInfo];
}

+ (NSError *)pk_requestCancelledError {
  NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
  [userInfo setObject:NSLocalizedString(@"The request was cancelled.", nil) forKey:NSLocalizedDescriptionKey];
  
  return [NSError errorWithDomain:PKPodioKitErrorDomain code:PKErrorCodeRequestCancelled userInfo:userInfo];
}

+ (NSError *)pk_responseParseError {
  NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
  [userInfo setObject:NSLocalizedString(@"Unable to read the server response.", nil) forKey:NSLocalizedDescriptionKey];
  
  return [NSError errorWithDomain:PKPodioKitErrorDomain code:PKErrorCodeParsingFailed userInfo:userInfo];
}

+ (NSError *)pk_serverErrorWithStatusCode:(NSUInteger)statusCode parsedData:(id)parsedData {
  NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
  [userInfo setObject:NSLocalizedString(@"A server error occurred.", nil) forKey:NSLocalizedDescriptionKey];
  [userInfo setObject:@(statusCode) forKey:PKErrorStatusCodeKey];

  if (parsedData && [parsedData isKindOfClass:[NSDictionary class]]) {
    NSString *errorId = [parsedData pk_objectForKey:@"error"];
    NSNumber *propagate = [parsedData pk_objectForKey:@"error_propagate"];
    NSString *description = [parsedData pk_objectForKey:@"error_description"];

    if (propagate && description) {
      NSError *underlyingError = [NSError errorWithDomain:PKPodioKitErrorDomain code:statusCode userInfo:@{
                                       PKErrorErrorIdKey : errorId,
                                  PKErrorResponseDataKey : parsedData,
                                     PKErrorPropagateKey : propagate,
                               NSLocalizedDescriptionKey : description,
                                  }];
      
      [userInfo setObject:underlyingError forKey:NSUnderlyingErrorKey];
    }
  }
  
  return [NSError errorWithDomain:PKPodioKitErrorDomain code:PKErrorCodeServerError userInfo:userInfo];
}

- (NSError *)pk_underlyingError {
  return [[self userInfo] objectForKey:NSUnderlyingErrorKey];
}

- (BOOL)pk_isServerSideError {
  return [self.domain isEqualToString:PKPodioKitErrorDomain] && self.code == PKErrorCodeServerError;
}

- (BOOL)pk_isNetworkError {
  return [self.domain isEqualToString:NSURLErrorDomain];
}

- (NSString *)pk_serverSideDescription {
  return [self pk_serverSideDescriptionPropagateRequired:NO];
}

- (NSString *)pk_humanServerSideDescription {
  return [self pk_serverSideDescriptionPropagateRequired:YES];
}

- (NSString *)pk_serverSideDescriptionPropagateRequired:(BOOL)propagateRequired {
  NSString *description = nil;
  
  if ([self pk_isServerSideError]) {
    NSError *error = [self pk_underlyingError];
    
    if (!propagateRequired || [error.userInfo[PKErrorPropagateKey] boolValue]) {
      description = [error localizedDescription];
    }
  }
  
  return description;
}

- (NSString *)pk_serverSideErrorId {
  NSString *errorId = nil;
  
  if ([self pk_isServerSideError]) {
    NSError *error = [self pk_underlyingError];
    if (error) {
      errorId = error.userInfo[PKErrorErrorIdKey];
    }
  }
  
  return errorId;
}

- (BOOL)pk_isServerSideErrorWithId:(NSString *)errorId {
  return [[self pk_serverSideErrorId] isEqualToString:errorId];
}

- (NSInteger)pk_serverSideErrorStatusCode {
  NSInteger statusCode = 0;
  
  if ([self pk_isServerSideError]) {
    NSError *serverError = [self pk_underlyingError];
    if (serverError) {
      statusCode = serverError.code;
    }
  }
  
  return statusCode;
}

- (BOOL)pk_isServerSideErrorWithStatusCode:(NSUInteger)statusCode {
  return [self pk_serverSideErrorStatusCode] == statusCode;
}

@end
