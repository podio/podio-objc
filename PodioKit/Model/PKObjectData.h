//
//  PKTransformableData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+PKAdditions.h"


@interface PKObjectData : NSObject <NSCoding> {
    
}

+ (instancetype)data;

+ (instancetype)dataFromDictionary:(NSDictionary *)dict;

+ (NSArray *)dataObjectsFromArray:(NSArray *)dicts;

@end
