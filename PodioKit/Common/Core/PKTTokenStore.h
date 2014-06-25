//
//  PKTTokenStore.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTOAuth2Token.h"

@protocol PKTTokenStore <NSObject>

- (void)storeToken:(PKTOAuth2Token *)token;

- (void)deleteStoredToken;

- (PKTOAuth2Token *)storedToken;

@end
