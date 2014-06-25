//
//  PKTDuration 
//  PodioKit
//
//  Created by Sebastian Rehnby on 15/05/14
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTDuration.h"

static NSUInteger const kSecondsInHour = 3600;
static NSUInteger const kSecondsInMinute = 60;

@implementation PKTDuration

- (instancetype)initWithHours:(NSUInteger)hours minutes:(NSUInteger)minutes seconds:(NSUInteger)seconds {
  self = [super init];
  if (!self) return nil;

  _hours = hours;
  _minutes = minutes;
  _seconds = seconds;

  return self;
}

- (instancetype)initWithTotalSeconds:(NSUInteger)totalSeconds {
  self = [super init];
  if (!self) return nil;

  self.totalSeconds = totalSeconds;

  return self;
}

#pragma mark - Properties

- (NSUInteger)totalSeconds {
  return self.hours * kSecondsInHour + self.minutes * kSecondsInMinute + self.seconds;
}

- (void)setTotalSeconds:(NSUInteger)totalSeconds {
  NSUInteger remainingSeconds = totalSeconds;

  self.hours = remainingSeconds / kSecondsInHour;

  remainingSeconds -= self.hours * kSecondsInHour;
  self.minutes = remainingSeconds / kSecondsInMinute;

  remainingSeconds -= self.minutes * kSecondsInMinute;
  self.seconds = remainingSeconds;
}

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"totalSeconds" : @"value"
  };
}

@end