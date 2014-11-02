//
//  PKTPushCredential.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@interface PKTPushCredential : PKTModel <NSCopying>

@property (nonatomic, copy, readonly) NSString *channel;
@property (nonatomic, copy, readonly) NSDate *expiresOn;
@property (nonatomic, copy, readonly) NSString *signature;
@property (nonatomic, copy, readonly) NSNumber *timestamp;

@end
