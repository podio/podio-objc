//
//  NSObject+PKTIntrospection.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <objc/runtime.h>
#import "NSObject+PKTIntrospection.h"

@implementation NSObject (PKTIntrospection)

+ (id)pkt_valueByPerformingSelectorWithName:(NSString *)selectorName {
  id value = nil;
  
  SEL selector = NSSelectorFromString(selectorName);
  if ([self respondsToSelector:selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    value = [self performSelector:selector];
#pragma clang diagnostic pop
  }
  
  return value;
}

@end
