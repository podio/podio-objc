//
//  POTransformableData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+PKAdditions.h"


@interface PKObjectData : NSObject <NSCoding> {
    
}

- (id)initWithCoder:(NSCoder *)aDecoder;

- (void)encodeWithCoder:(NSCoder *)aCoder;

+ (id)data;

+ (id)dataFromDictionary:(NSDictionary *)dict;

+ (NSArray *)dataObjectsFromArray:(NSArray *)dicts;

@end
