//
//  PKTransformableData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"
#import "NSArray+PKAdditions.h"


@implementation PKObjectData

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  return [super init];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
}

+ (instancetype)data {
  return [self new];
}

+ (instancetype)dataFromDictionary:(NSDictionary *)dict {
  return nil;
}

+ (NSArray *)dataObjectsFromArray:(NSArray *)dicts {
  NSArray *objects = [dicts pk_arrayFromObjectsCollectedWithBlock:^id(id dict) {
    return [self dataFromDictionary:dict];
  }];

  return objects;
}

@end
