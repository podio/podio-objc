//
//  PKTRequestFileData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 01/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTRequestFileData.h"

@implementation PKTRequestFileData

- (instancetype)initWithData:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName {
  self = [super init];
  if (!self) return nil;
  
  _data = data;
  _name = [name copy];
  _fileName = [fileName copy];
  
  return self;
}

- (instancetype)initWithFilePath:(NSString *)filePath name:(NSString *)name fileName:(NSString *)fileName {
  self = [super init];
  if (!self) return nil;
  
  _filePath = [filePath copy];
  _name = [name copy];
  _fileName = [fileName copy];
  
  return self;
}

+ (instancetype)fileDataWithData:(NSData *)data name:(NSString *)name fileName:(NSString *)fileName {
  return [[self alloc] initWithData:data name:name fileName:fileName];
}

+ (instancetype)fileDataWithFilePath:(NSString *)filePath name:(NSString *)name fileName:(NSString *)fileName {
  return [[self alloc] initWithFilePath:filePath name:name fileName:fileName];
}

@end
