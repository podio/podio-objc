//
//  PKTRequestFileData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 01/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKTRequestFileData : NSObject

@property (nonatomic, strong) NSData *data;
@property (nonatomic, copy, readonly) NSURL *fileURL;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *fileName;
@property (nonatomic, copy, readonly) NSString *mimeType;

+ (instancetype)fileDataWithData:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType;

+ (instancetype)fileDataWithFileURL:(NSURL *)fileURL name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType;

@end
