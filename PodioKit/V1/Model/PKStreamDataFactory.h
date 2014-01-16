//
//  PKStreamDataFactory.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKStreamDataFactory : NSObject

+ (id)dataFromDictionary:(NSDictionary *)dict objectType:(PKReferenceType)objectType;

@end
