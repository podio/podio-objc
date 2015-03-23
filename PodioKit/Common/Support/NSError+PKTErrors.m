//
//  NSError+PKTErrors.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSError+PKTErrors.h"
#import "NSDictionary+PKTAdditions.h"

NSString * const PodioServerErrorDomain = @"PodioServerErrorDomain";

NSString * const PKTErrorKey = @"PKTError";
NSString * const PKTErrorDescriptionKey = @"PKTErrorDescription";
NSString * const PKTErrorDetailKey = @"PKTErrorDetail";
NSString * const PKTErrorParametersKey = @"PKTErrorParameters";
NSString * const PKTErrorPropagateKey = @"PKTErrorPropagate";

@implementation NSError (PKTErrors)

#pragma mark - Public

+ (NSError *)pkt_serverErrorWithStatusCode:(NSUInteger)statusCode body:(id)body {
  return [NSError errorWithDomain:PodioServerErrorDomain code:statusCode userInfo:[self pkt_userInfoFromBody:body]];
}

- (BOOL)pkt_isServerError {
  return [self.domain isEqualToString:PodioServerErrorDomain] && self.code > 0;
}

- (NSString *)pkt_localizedServerSideDescription {
  return [self pkt_shouldPropagate] ? self.userInfo[PKTErrorDescriptionKey] : nil;
}

#pragma mark - Private

- (BOOL)pkt_shouldPropagate {
  return [self pkt_isServerError] && [self.userInfo[PKTErrorPropagateKey] boolValue] == YES;
}

+ (NSDictionary *)pkt_userInfoFromBody:(id)body {
  if (![body isKindOfClass:[NSDictionary class]]) return nil;
  
  NSDictionary *errorDict = body;
  
  NSMutableDictionary *userInfo = [NSMutableDictionary new];
  
  NSString *error = [errorDict pkt_nonNullObjectForKey:@"error"];
  NSString *errorDescription = [errorDict pkt_nonNullObjectForKey:@"error_description"];
  NSString *errorDetail = [errorDict pkt_nonNullObjectForKey:@"error_detail"];
  NSDictionary *errorParameters = [errorDict pkt_nonNullObjectForKey:@"error_parameters"];
  NSNumber *errorPropagate = [errorDict pkt_nonNullObjectForKey:@"error_propagate"];
  
  if (errorDescription && [errorPropagate boolValue]) userInfo[NSLocalizedDescriptionKey] = errorDescription;
  if (error) userInfo[PKTErrorKey] = error;
  if (errorDescription) userInfo[PKTErrorDescriptionKey] = errorDescription;
  if (errorDetail) userInfo[PKTErrorDetailKey] = errorDetail;
  if (errorParameters) userInfo[PKTErrorParametersKey] = errorParameters;
  if (errorPropagate) userInfo[PKTErrorPropagateKey] = errorPropagate;
  
  return [userInfo copy];
}

@end
