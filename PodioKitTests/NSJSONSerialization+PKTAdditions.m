//
//  NSJSONSerialization+PKTAdditions.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSJSONSerialization+PKTAdditions.h"

@implementation NSJSONSerialization (PKTAdditions)

+ (id)pkt_JSONObjectFromFileWithName:(NSString *)fileName inBundleForClass:(Class)klass {
  NSArray *comps = [fileName componentsSeparatedByString:@"."];
  if ([comps count] != 2) {
    return nil;
  }
  
  NSString *resource = comps[0];
  NSString *type = comps[1];
  
  id obj = nil;
  
  NSString *path = [[NSBundle bundleForClass:klass] pathForResource:resource ofType:type];
  if (path) {
    NSData *data = [NSData dataWithContentsOfFile:path];
    if (data) {
      obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    }
  }
  
  return obj;
}

@end
