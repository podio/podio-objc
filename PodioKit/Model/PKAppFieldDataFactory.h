//
//  PKAppFieldDataFactory.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 4/11/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKAppFieldDataFactory : NSObject

+ (id)dataFromDictionary:(NSDictionary *)dict type:(PKAppFieldType)type;

@end
