//
//  PKTNumberValueTransformer 
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/05/14
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTNumberValueTransformer.h"
#import "NSNumber+PKTAdditions.h"


@implementation PKTNumberValueTransformer

#pragma mark - NSValueTransformer

+ (BOOL)allowsReverseTransformation {
  return YES;
}

- (id)reverseTransformedValue:(id)value {
  if (![value isKindOfClass:[NSNumber class]]) {
       return nil;
  }

  return [(NSNumber *)value pkt_USNumberString];
}

- (id)transformedValue:(id)value {
  if (![value isKindOfClass:[NSString class]]) {
    return nil;
  }

  return [NSNumber pkt_numberFromUSNumberString:value];
}


@end