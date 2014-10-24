//
//  PKTDatastore.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTDatastore.h"
#import "PKTAsyncTask.h"
#import "PKTMacros.h"
#import "NSString+PKTURLEncode.h"

#if PKT_IOS_SDK_AVAILABLE
#import <UIKit/UIKit.h>
#endif

/**
 *  Keep a simple version integer. Bump whenever backwards compatability is broken. The version will be
 *  reflected int the file path on disk for the stored objects.
 */
static NSUInteger const kVersion = 1;

/**
 *  Prefix custom stores to avoid collision with shared store.
 */
static NSString * const kStoreNamePrefix = @"_";

static NSString * const kSharedStoreName = @"SharedStore";
static char * const kInternalQueueName = "com.podio.podiokit.pktdatastore.internal_queue";

@interface PKTDatastore ()

@property (nonatomic, copy, readonly) NSString *path;
@property (nonatomic, copy, readonly) NSString *dataPath;
@property (nonatomic, strong, readonly) NSCache *cache;
@property (nonatomic, strong, readonly) NSFileManager *fileManager;

@end

@implementation PKTDatastore {
  dispatch_queue_t _internalQueue;
}

@synthesize dataPath = _dataPath;
@synthesize cache = _cache;
@synthesize fileManager = _fileManager;

- (instancetype)initWithPath:(NSString *)path name:(NSString *)name shouldPrefixName:(BOOL)shouldPrefixName {
  self = [super init];
  if (!self) return nil;
  
  _path = path ? [path copy] : [[self class] defaultPathWithName:name shouldPrefixName:shouldPrefixName];
  _internalQueue = dispatch_queue_create(kInternalQueueName, DISPATCH_QUEUE_CONCURRENT);
  _fileManager = [NSFileManager new];
  
#if PKT_IOS_SDK_AVAILABLE
  _cache = [NSCache new];
#endif
  
  [self registerNotifications];
  
  return self;
}

- (instancetype)init {
  return [self initWithPath:nil name:nil shouldPrefixName:YES];
}

- (instancetype)initWithPath:(NSString *)path {
  return [self initWithPath:path name:nil shouldPrefixName:YES];
}

- (instancetype)initWithName:(NSString *)name {
  return [self initWithPath:nil name:name shouldPrefixName:YES];
}

- (void)dealloc {
  [self unregisterNotifications];
}

+ (instancetype)sharedStore {
  static id sharedStore;
  static dispatch_once_t once;
  
  dispatch_once(&once, ^{
    sharedStore = [[self alloc] initWithPath:nil name:kSharedStoreName shouldPrefixName:NO];
  });
  
  return sharedStore;
}

+ (instancetype)storeWithName:(NSString *)name {
  return [[self alloc] initWithName:name];
}

+ (instancetype)storeWithPath:(NSString *)path {
  return [[self alloc] initWithPath:path];
}

#pragma mark - Properties

- (NSString *)dataPath {
  if (!_dataPath) {
    _dataPath = [self.path stringByAppendingPathComponent:@"Data"];
  }
  
  return _dataPath;
}

#pragma mark - Subscripting

- (id)objectForKeyedSubscript:(id <NSCopying>)key {
  NSParameterAssert([(id)key isKindOfClass:[NSString class]]);
  
  return [self storedObjectForKey:(NSString *)key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key {
  NSParameterAssert([(id)key isKindOfClass:[NSString class]]);
  
  [self storeObject:obj forKey:(NSString *)key];
}

#pragma mark - Public

- (void)storeObject:(id<NSCoding>)object forKey:(NSString *)key {
  NSParameterAssert(key);

  dispatch_barrier_async(_internalQueue, ^{
    NSString *path = [self objectFilePathForkey:key];
    
    if (object) {
      if (![self.fileManager fileExistsAtPath:self.dataPath isDirectory:NULL]) {
        NSError *error = nil;
        [self.fileManager createDirectoryAtPath:self.dataPath withIntermediateDirectories:YES attributes:nil error:&error];
        
        if (error) {
          NSLog(@"ERROR: Failed to create data directory at path %@", self.dataPath);
        }
      }
      
      BOOL archived = [NSKeyedArchiver archiveRootObject:object toFile:path];
      if (archived) {
        [self.cache setObject:object forKey:key];
      } else {
        NSLog(@"ERROR: Failed to store object at path %@", self.dataPath);
      }
    } else {
      [self.cache removeObjectForKey:key];
      
      if ([self.fileManager fileExistsAtPath:path isDirectory:NULL]) {
        NSError *error = nil;
        [self.fileManager removeItemAtPath:path error:&error];
        
        if (error) {
          NSLog(@"ERROR: Failed to remove stored object at path %@", path);
        }
      }
    }
  });
}

- (id<NSCopying>)storedObjectForKey:(NSString *)key {
  NSParameterAssert(key);
  
  __block id obj = nil;
  
  dispatch_sync(_internalQueue, ^{
    obj = [self.cache objectForKey:key];
    
    if (!obj) {
      NSString *path = [self objectFilePathForkey:key];
      obj = [NSKeyedUnarchiver unarchiveObjectWithFile:path];

      if (obj) {
        dispatch_barrier_async(_internalQueue, ^{
          [self.cache setObject:obj forKey:key];
        });
      }
    }
  });
  
  return obj;
}

- (PKTAsyncTask *)fetchStoredObjectForKey:(NSString *)key {
  return [PKTAsyncTask taskForBlock:^PKTAsyncTaskCancelBlock(PKTAsyncTaskResolver *resolver) {
    PKT_WEAK_SELF weakSelf = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
      PKT_STRONG(weakSelf) strongSelf = weakSelf;
      
      id obj = [strongSelf storedObjectForKey:key];
      [resolver succeedWithResult:obj];
    });
    
    return nil;
  }];
}

- (BOOL)storedObjectExistsForKey:(NSString *)key {
  NSParameterAssert(key);
  
  __block BOOL exists = NO;
  
  dispatch_sync(_internalQueue, ^{
    exists = [self.cache objectForKey:key] != nil;
    
    if (!exists) {
      NSString *path = [self objectFilePathForkey:key];
      exists = [self.fileManager fileExistsAtPath:path isDirectory:NULL];
    }
  });
  
  return exists;
}

#pragma mark - Private

- (void)registerNotifications {
#if PKT_IOS_SDK_AVAILABLE
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(clearCache)
                                               name:UIApplicationDidReceiveMemoryWarningNotification
                                             object:nil];
#endif
}

- (void)unregisterNotifications {
#if PKT_IOS_SDK_AVAILABLE
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIApplicationDidReceiveMemoryWarningNotification
                                                object:nil];
#endif
}

- (void)clearCache {
  dispatch_barrier_async(_internalQueue, ^{
    [self.cache removeAllObjects];
  });
}

- (NSString *)objectFilePathForkey:(NSString *)key {
  NSParameterAssert(key);
  
  NSString *component = [key pkt_encodeString];
  NSString *path = [self.dataPath stringByAppendingPathComponent:component];
  
  return path;
}

+ (NSString *)defaultPathWithName:(NSString *)name shouldPrefixName:(BOOL)shouldPrefixName {
  NSParameterAssert([name length] > 0);
  
  // Put data in documents by default
  NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
  path = [path stringByAppendingPathComponent:@"com.podio.PodioKit"];
  path = [path stringByAppendingPathComponent:@"Stores"];
  
  // Namespace by version
  NSString *version = [NSString stringWithFormat:@"v%@", @([self datastoreVersion])];
  path = [path stringByAppendingPathComponent:version];
  
  // Finally append the chosen name, prefix if needed
  NSString *storeName = shouldPrefixName ? [NSString stringWithFormat:@"%@%@", kStoreNamePrefix, name] : name;
  path = [path stringByAppendingPathComponent:storeName];
  
  return path;
}

+ (NSUInteger)datastoreVersion {
  return kVersion;
}

@end
