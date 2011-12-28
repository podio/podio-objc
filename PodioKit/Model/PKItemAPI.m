//
//  POItemAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKItemAPI.h"

@implementation PKItemAPI

+ (PKRequest *)requestForItemWithId:(NSUInteger)itemId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/%d", itemId] method:PKAPIRequestMethodGET];
}

@end
