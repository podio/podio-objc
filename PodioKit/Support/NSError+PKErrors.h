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

+ (NSError *)po_noConnectionError;
+ (NSError *)po_responseParseError;
+ (NSError *)po_serverErrorWithStatusCode:(NSUInteger)statusCode responseString:(NSString *)responseString;

@end
