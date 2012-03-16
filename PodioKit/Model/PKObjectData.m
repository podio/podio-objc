//
//  PKTransformableData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKObjectData.h"
#import "NSArray+PKAdditions.h"


@implementation PKObjectData

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
}

+ (id)data {
  return [[self alloc] init];
}

+ (id)dataFromDictionary:(NSDictionary *)dict {
  return nil;
}

+ (NSArray *)dataObjectsFromArray:(NSArray *)dicts {
  NSArray *objects = [dicts pk_arrayFromObjectsCollectedWithBlock:^id(id dict) {
    return [self dataFromDictionary:dict];
  }];

  return objects;
}

@end
