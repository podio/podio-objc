//
//  PKTransformableData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKObjectData.h"


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
  NSMutableArray *mutObjects = [[NSMutableArray alloc] initWithCapacity:[dicts count]];
  for (NSDictionary *dict in dicts) {
    id data = [self dataFromDictionary:dict];
    [mutObjects addObject:data];
  }
  
  NSArray *objects = [NSArray arrayWithArray:mutObjects];
  
  return objects;
}

@end
