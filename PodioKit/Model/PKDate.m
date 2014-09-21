//
//  PKDate.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 21/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKDate.h"


static NSString * const kDateKey = @"Date";
static NSString * const kIncludesTimeComponentKey = @"IncludesTimeComponent";

@interface PKDate ()

@property (nonatomic, copy) NSDate *date;
@property (nonatomic, assign) BOOL includesTimeComponent;

@end

@implementation PKDate

- (instancetype)initWithDate:(NSDate *)date includesTimeComponent:(BOOL)includesTimeComponent {
  NSParameterAssert(date);
  
  self = [super init];
  if (!self) return nil;
  
  self.date = date;
  self.includesTimeComponent = includesTimeComponent;
  
  return self;
}

+ (instancetype)dateWithDate:(NSDate *)date includesTimeComponent:(BOOL)includesTimeComponent {
  return [[self alloc] initWithDate:date includesTimeComponent:includesTimeComponent];
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)aDecoder {
  NSDate *date = [aDecoder decodeObjectForKey:kDateKey];
  BOOL includesTimeComponent = [aDecoder decodeBoolForKey:kIncludesTimeComponentKey];
  
  return [self initWithDate:date includesTimeComponent:includesTimeComponent];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.date forKey:kDateKey];
  [aCoder encodeBool:self.includesTimeComponent forKey:kIncludesTimeComponentKey];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  return [[[self class] allocWithZone:zone] initWithDate:self.date
                                   includesTimeComponent:self.includesTimeComponent];
}

@end
