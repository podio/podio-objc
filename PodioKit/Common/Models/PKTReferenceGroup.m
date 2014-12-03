//
//  PKTReferenceGroup.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/12/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTReferenceGroup.h"
#import "PKTProfile.h"
#import "PKTApp.h"
#import "PKTWorkspace.h"
#import "PKTByLine.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTReferenceGroup

#pragma mark - PKTModel

+ (NSValueTransformer *)contentsValueTransformerWithDictionary:(NSDictionary *)dictionary {
  NSString *name = dictionary[@"name"];
  
  Class klass = nil;
  if ([name isEqualToString:@"profiles"]) {
    klass = [PKTProfile class];
  } else if ([name isEqualToString:@"app"]) {
    klass = [PKTApp class];
  } else if ([name isEqualToString:@"spaces"]) {
    klass = [PKTWorkspace class];
  }
  
  return [NSValueTransformer pkt_transformerWithModelClass:klass];
}

@end
