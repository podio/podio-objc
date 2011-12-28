//
//  POManagedObject.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 8/7/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKManagedObject.h"

@implementation PKManagedObject

#pragma mark - Mappable object

+ (NSArray *)identityPropertyNames {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

@end
