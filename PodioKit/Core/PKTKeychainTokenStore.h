//
//  PKTKeychainTokenStore.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTTokenStore.h"

@class PKTKeychain;

@interface PKTKeychainTokenStore : NSObject <PKTTokenStore>

@property (nonatomic, strong, readonly) PKTKeychain *keychain;

- (instancetype)initWithService:(NSString *)service;

- (instancetype)initWithService:(NSString *)service accessGroup:(NSString *)accessGroup;

- (instancetype)initWithKeychain:(PKTKeychain *)keychain;

@end
