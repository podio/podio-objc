//
//  PKTUser.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 30/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@class PKTAsyncTask;

@interface PKTUser : PKTModel

@property (nonatomic, assign, readonly) NSUInteger userID;
@property (nonatomic, copy, readonly) NSString *mail;

+ (PKTAsyncTask *)fetchCurrent;

@end
