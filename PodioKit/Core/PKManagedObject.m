//
//  PKManagedObject.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 8/7/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKManagedObject.h"

@implementation PKManagedObject

#pragma mark - Mappable object

+ (NSArray *)identityPropertyNames {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

@end
