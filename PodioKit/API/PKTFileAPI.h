//
//  PKTFileAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 01/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"

@interface PKTFileAPI : PKTBaseAPI

+ (PKTRequest *)requestToUploadFileWithData:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mimeType;
+ (PKTRequest *)requestToUploadFileWithURL:(NSURL *)fileURL fileName:(NSString *)fileName mimeType:(NSString *)mimeType;

@end
