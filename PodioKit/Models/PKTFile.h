//
//  PKTFile.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTObject.h"

#define PKTImage UIImage

@interface PKTFile : PKTObject

@property (nonatomic, assign, readonly) NSUInteger fileID;

#pragma mrk - API

+ (void)uploadWithImage:(PKTImage *)image fileName:(NSString *)fileName completion:(void (^)(PKTFile *file, NSError *error))completion;

+ (void)uploadWithData:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mimeType completion:(void (^)(PKTFile *file, NSError *error))completion;

@end
