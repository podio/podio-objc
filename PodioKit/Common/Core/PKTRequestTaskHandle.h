//
//  PKTRequestTaskHandle.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 08/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PKTRequest;
@class PKTRequestTaskDescriptor;

@interface PKTRequestTaskHandle : NSObject

@property (nonatomic, strong, readonly) PKTRequest *request;

+ (instancetype)handleForDescriptor:(PKTRequestTaskDescriptor *)descriptor;

- (void)cancel;

@end
