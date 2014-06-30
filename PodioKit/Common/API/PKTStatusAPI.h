//
//  PKTStatusAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 30/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"

@interface PKTStatusAPI : PKTBaseAPI

+ (PKTRequest *)requestForStatusMessageWithID:(NSUInteger)statusID;

+ (PKTRequest *)requestToAddNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID;

+ (PKTRequest *)requestToAddNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID files:(NSArray *)files;

+ (PKTRequest *)requestToAddNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID files:(NSArray *)files embedID:(NSUInteger)embedID;

+ (PKTRequest *)requestToAddNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID files:(NSArray *)files embedURL:(NSURL *)embedURL;

@end
