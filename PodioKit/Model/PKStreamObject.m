//
//  PKStreamObject.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/11/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKStreamObject.h"

@implementation PKStreamObject

@synthesize objectType = objectType_;
@synthesize objectId = objectId_;
@synthesize title = title_;


#pragma mark - PKMappableObject

+ (NSArray *)identityPropertyNames {
  return [NSArray arrayWithObjects:@"objectId", @"objectType", nil];
}

@end
