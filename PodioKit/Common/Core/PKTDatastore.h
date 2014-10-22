//
//  PKTDatastore.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PKTAsyncTask;

/**
 *  Thread safe implementation of a disk backed key/value store with built-in caching.
 */
@interface PKTDatastore : NSObject

/**
 *  Accesses the shared data store.
 *
 *  @return The shared data store.
 */
+ (instancetype)sharedStore;

/**
 *  Returns an existing or creates a new data store at the given path.
 *
 *  @param path The file path of the store.
 *
 *  @return An existing store if it exists at the given path, otherwise a new store.
 */
- (instancetype)initWithPath:(NSString *)path;

/**
 *  Returns an existing or creates a new data store with the given name.
 *
 *  @param name The unique name of the data store.
 *
 *  @return An existing store if it exists on disk, otherwise a new store.
 */
- (instancetype)initWithName:(NSString *)name;

/**
 *  @see initWithName:
 */
+ (instancetype)storeWithName:(NSString *)name;

/**
 *  @see initWithPath:
 */
+ (instancetype)storeWithPath:(NSString *)path;

/**
 *  Stores an object to disk.
 *
 *  @param object The object to persist.
 *  @param key    The key used to uniquely identify the stored object.
 */
- (void)storeObject:(id<NSCoding>)object forKey:(NSString *)key;

/**
 *  Retrieves a stored object from the cache or disk.
 *
 *  @param key The key used to uniquely identify the stored object.
 *
 *  @return The object if it exists in cache or on disk, otherwise nil.
 */
- (id<NSCopying>)storedObjectForKey:(NSString *)key;

/**
 *  Retrieves a stored object from the cache asynchronously.
 *
 *  @param key        The key used to uniquely identify the stored object.
 
 *  @return The task delivering the object if found, otherwise nil, upon completion.
 */
- (PKTAsyncTask *)fetchStoredObjectForKey:(NSString *)key;

/**
 *  Checks whether the stored object exists either in cache or on disk.
 *
 *  @param key The key used to uniquely identify the stored object.
 *
 *  @return YES if the object exists in cache or on disk, otherwise NO.
 */
- (BOOL)storedObjectExistsForKey:(NSString *)key;

#pragma mark - Subscripting

- (id)objectForKeyedSubscript:(id <NSCopying>)key;
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

@end
