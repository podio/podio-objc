//
//  PKBaseObject.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/11/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKBaseObject.h"

@implementation PKBaseObject

+ (NSArray *)identityPropertyNames {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

@end
