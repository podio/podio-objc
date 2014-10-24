//
//  PKTSecurity.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 24/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKTSecurity : NSObject

- (BOOL)evaluateServerTrust:(SecTrustRef)trust;

@end
