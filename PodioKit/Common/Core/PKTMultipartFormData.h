//
//  PKTMultipartFormData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PKTRequest;

@interface PKTMultipartFormData : NSObject

@property (nonatomic, strong, readonly) NSData *finalizedData;
@property (nonatomic, copy, readonly) NSString *stringRepresentation;

+ (instancetype)multipartFormDataWithBoundary:(NSString *)boundary encoding:(NSStringEncoding)encoding;

- (void)appendFileData:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mimeType name:(NSString *)name;

- (void)appendFormDataParameters:(NSDictionary *)parameters;

- (void)finalizeData;

@end
