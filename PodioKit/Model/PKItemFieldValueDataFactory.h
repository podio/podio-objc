//
//  PKItemFieldValueDataFactory.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/4/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKItemFieldValueDataFactory : NSObject

+ (id)dataFromDictionary:(NSDictionary *)dict fieldType:(PKAppFieldType)fieldType;

@end
