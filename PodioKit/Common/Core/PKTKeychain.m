//
//  PKTKeychain.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Security/Security.h>
#import "PKTKeychain.h"

@implementation PKTKeychain

- (instancetype)init {
  return [self initWithService:nil accessGroup:nil];
}

- (instancetype)initWithService:(NSString *)service accessGroup:(NSString *)accessGroup {
  self = [super init];
  if (!self) return nil;
  
  _service = [service copy];
  _accessGroup = [accessGroup copy];
  
  return self;
}

+ (instancetype)keychainForService:(NSString *)service accessGroup:(NSString *)accessGroup {
  return [[self alloc] initWithService:service accessGroup:accessGroup];
}

#pragma mark - Keychain access

- (id)objectForKey:(id)key {
  id object = nil;
  
  NSData *data = [self dataForKey:key];
  if (data) {
    object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
  }
  
  return object;
}

- (BOOL)setObject:(id<NSCoding>)object forKey:(id)key {
  NSData *data = nil;
  if (object) {
    data = [NSKeyedArchiver archivedDataWithRootObject:object];
  }
  
  return [self setData:data forKey:key];
}

- (NSDictionary *)queryForKey:(id)key returnData:(BOOL)returnData limitOne:(BOOL)limitOne {
  NSMutableDictionary *query = [NSMutableDictionary new];
  
  if ([self.service length] > 0) {
    query[(__bridge NSString *)kSecAttrService] = self.service;
  }
  
  query[(__bridge NSString *)kSecClass] = (__bridge NSString *)kSecClassGenericPassword;
  query[(__bridge NSString *)kSecAttrAccount] = [key description];
  
#if TARGET_OS_IPHONE && !TARGET_IPHONE_SIMULATOR
  if (self.accessGroup) {
    query[(__bridge NSString *)kSecAttrAccessGroup] = self.accessGroup;
  }
#endif
  
  if (returnData) {
    query[(__bridge NSString *)kSecReturnData] = (__bridge id)kCFBooleanTrue;
  }
  
  if (limitOne) {
    query[(__bridge NSString *)kSecMatchLimit] = (__bridge id)kSecMatchLimitOne;
  }
  
  return [query copy];
}

- (NSData *)dataForKey:(id)key {
  NSParameterAssert(key);
  
  NSDictionary *query = [self queryForKey:key returnData:YES limitOne:YES];
  
  OSStatus status = errSecSuccess;
  CFDataRef dataRef = NULL;
  
  status = SecItemCopyMatching((__bridge CFDictionaryRef)(query), (CFTypeRef *)&dataRef);
  
  NSData *data = nil;
  if (status == errSecItemNotFound) {
    NSLog(@"Count not find Keychain item for key '%@'", [key description]);
  } else if (status != errSecSuccess) {
    NSLog(@"Failed to retrieve Keychain item for key '%@'", [key description]);
  } else if (dataRef != NULL) {
    // Item found
    data = CFBridgingRelease(dataRef);
  }
  
  return data;
}

- (BOOL)setData:(NSData *)data forKey:(id)key {
  NSParameterAssert(key);
  
  BOOL success = YES;
  
  NSDictionary *query = [self queryForKey:key returnData:NO limitOne:NO];

  OSStatus status = errSecSuccess;
  if (data) {
    NSDictionary *dataDict = @{ (__bridge NSString *)kSecValueData: data };
    
    if ([self objectForKey:key]) {
      // Item already exists, update it
      status = SecItemUpdate((__bridge CFDictionaryRef)(query), (__bridge CFDictionaryRef)(dataDict));
      
      if (status != errSecSuccess) {
        success = NO;
        NSLog(@"Failed to update existing Keychain item with status: %@", @(status));
      }
    } else {
      // Add a new item
      NSMutableDictionary *mutQuery = [query mutableCopy];
      [mutQuery addEntriesFromDictionary:dataDict];
      query = [mutQuery copy];
      
      status = SecItemAdd((__bridge CFDictionaryRef)(query), NULL);
      
      if (status != errSecSuccess) {
        success = NO;
        NSLog(@"Failed to add Keychain item with status: %@", @(status));
      }
    }
  } else if ([self objectForKey:key]) {
    // Delete existing item
    SecItemDelete((__bridge CFDictionaryRef)(query));
    
    if (status != errSecSuccess) {
     success = NO;
      NSLog(@"Failed to delete Keychain item with status: %@", @(status));
    }
  }
  
  return success;
}

- (BOOL)removeObjectForKey:(id)key {
  return [self setObject:nil forKey:key];
}

@end
