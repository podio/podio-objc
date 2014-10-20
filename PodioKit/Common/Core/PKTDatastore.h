//
//  PKTDatastore.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

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
 *  Returns an existing or creates a new data store with the given name.
 *
 *  @param name The unique name of the data store.
 *
 *  @return An existing store if it exists on disk, otherwise a new store.
 */
+ (instancetype)storeWithName:(NSString *)name;

/**
 *  Returns an existing or creates a new data store at the given path.
 *
 *  @param path The file path of the store.
 *
 *  @return An existing store if it exists at the given path, otherwise a new store.
 */
+ (instancetype)storeWithPath:(NSString *)path;

- (void)storeObject:(id<NSCoding>)object forKey:(NSString *)key;

- (id<NSCopying>)storedObjectForKey:(NSString *)key;

#pragma mark - Subscripting

- (id)objectForKeyedSubscript:(id <NSCopying>)key;
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

@end
