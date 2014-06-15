//
//  PKTKeychainTokenStore.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTKeychainTokenStore.h"
#import "PKTKeychain.h"

static NSString * const kTokenKeychainKey = @"PodioKitOAuthToken";

@interface PKTKeychainTokenStore ()

@end

@implementation PKTKeychainTokenStore

- (instancetype)initWithService:(NSString *)service {
  return [self initWithService:service accessGroup:nil];
}

- (instancetype)initWithService:(NSString *)service accessGroup:(NSString *)accessGroup {
  PKTKeychain *keychain = [PKTKeychain keychainForService:service accessGroup:accessGroup];
  return [self initWithKeychain:keychain];
}

- (instancetype)initWithKeychain:(PKTKeychain *)keychain {
  self = [super init];
  if (!self) return nil;
  
  _keychain = keychain;
  
  return self;
}

#pragma mark - PKTTokenStore

- (void)storeToken:(PKTOAuth2Token *)token {
  [self.keychain setObject:token ForKey:kTokenKeychainKey];
}

- (void)deleteStoredToken {
  [self.keychain removeObjectForKey:kTokenKeychainKey];
}

- (PKTOAuth2Token *)storedToken {
  return [self.keychain objectForKey:kTokenKeychainKey];
}

@end
