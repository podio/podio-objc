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
@property (nonatomic, copy, readonly) NSString *filePath;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *fileName;

+ (instancetype)fileDataWithData:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName;

+ (instancetype)fileDataWithFilePath:(NSString *)filePath name:(NSString *)name fileName:(NSString *)fileName;

@end
