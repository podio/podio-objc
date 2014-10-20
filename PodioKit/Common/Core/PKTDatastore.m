//
//  PKTDatastore.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTDatastore.h"

/**
 *  Keep a simple version integer persist with the stored data. Bump whenever backwards compatability is broken.
 */
static NSUInteger const kVersion = 1;

/**
 *  The name of the shared store.
 */
static NSString * const kSharedStoreName = @"SharedStore";

@interface PKTDatastore ()

@property (nonatomic, copy) NSString *path;

@end

@implementation PKTDatastore

- (instancetype)initWithPath:(NSString *)path name:(NSString *)name {
  self = [super init];
  if (!self) return nil;
  
  _path = path ? [path copy] : [[self class] defaultPathWithName:name];
  
  return self;
}

- (instancetype)init {
  return [self initWithPath:nil];
}

- (instancetype)initWithPath:(NSString *)path {
  return [self initWithPath:path name:nil];
}

- (instancetype)initWithName:(NSString *)name {
  return [self initWithPath:nil name:name];
}

+ (instancetype)sharedStore {
  static id sharedStore;
  static dispatch_once_t once;
  
  dispatch_once(&once, ^{
    sharedStore = [[self alloc] initWithName:kSharedStoreName];
  });
  
  return sharedStore;
}

+ (instancetype)storeWithName:(NSString *)name {
  return [[self alloc] initWithName:name];
}
+ (instancetype)storeWithPath:(NSString *)path {
  return [[self alloc] initWithPath:path];
}

#pragma mark - Public

+ (NSUInteger)version {
  return kVersion;
}

#pragma mark - Private

+ (NSString *)defaultPathWithName:(NSString *)name {
  NSParameterAssert([name length] > 0);
  
  // Put data in documents by default
  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
  path = [path stringByAppendingPathComponent:@"PodioKit"];
  
  // Namespace by version
  NSString *version = [NSString stringWithFormat:@"v%@", @(kVersion)];
  path = [path stringByAppendingPathComponent:version];
  
  // Keep data stores in specific subdirectory 'Data'
  path = [path stringByAppendingPathComponent:@"Data"];
  
  // Name the store after the current app bundle
  path = [path stringByAppendingPathComponent:name];
  
  return path;
}

@end
