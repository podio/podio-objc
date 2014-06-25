//
//  PKTDurationItemFieldValue 
//  PodioKit
//
//  Created by Sebastian Rehnby on 15/05/14
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTDurationItemFieldValue.h"
#import "PKTDuration.h"


@implementation PKTDurationItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super initFromValueDictionary:valueDictionary];
  if (!self) return nil;

  NSUInteger totalSeconds = [valueDictionary[@"value"] unsignedIntegerValue];
  self.unboxedValue = [[PKTDuration alloc] initWithTotalSeconds:totalSeconds];

  return self;
}

- (NSDictionary *)valueDictionary {
  PKTDuration *duration = self.unboxedValue;

  return @{@"value" : @(duration.totalSeconds)};
}

+ (Class)unboxedValueClass {
  return [PKTDuration class];
}

@end