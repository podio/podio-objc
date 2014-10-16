//
//  PKDate.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 21/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKDate.h"
#import "NSDate+PKAdditions.h"


static NSString * const kInternalDateKey = @"InternalDate";
static NSString * const kIncludesTimeComponentKey = @"IncludesTimeComponent";

@interface PKDate ()

@property (nonatomic, copy) NSDate *internalDate;
@property (nonatomic, copy, readonly) NSDate *internalDateWithoutTime;
@property (nonatomic, assign) BOOL includesTimeComponent;

@end

@implementation PKDate

@synthesize internalDateWithoutTime = _internalDateWithoutTime;

- (instancetype)init {
  self = [super init];
  if (!self) return nil;
  
  _includesTimeComponent = YES;
  
  return self;
}

- (instancetype)initWithDate:(NSDate *)date includesTimeComponent:(BOOL)includesTimeComponent {
  NSParameterAssert(date);
  
  self = [super init];
  if (!self) return nil;
  
  _internalDate = [date copy];
  _includesTimeComponent = includesTimeComponent;
  
  return self;
}

+ (instancetype)dateWithDate:(NSDate *)date includesTimeComponent:(BOOL)includesTimeComponent {
  return [[self alloc] initWithDate:date includesTimeComponent:includesTimeComponent];
}

+ (instancetype)dateWithoutTimeComponentFromDateInCurrentTimeZone:(NSDate *)date {
  NSDate *utcDate = [date pk_convertedDateInCurrentCalendarToUTCFromCurrentTimeZone];
  return [[self alloc] initWithDate:utcDate includesTimeComponent:NO];
}

+ (instancetype)date {
  return [self dateWithDate:[NSDate date] includesTimeComponent:YES];
}

+ (instancetype)dateWithoutTimeComponent {
  return [self dateWithoutTimeComponentFromDateInCurrentTimeZone:[NSDate date]];
}

- (instancetype)copyWithoutTimeComponent {
  return [[self class] dateWithDate:self.internalDate includesTimeComponent:NO];
}

#pragma mark - NSDate

- (instancetype)initWithTimeIntervalSinceReferenceDate:(NSTimeInterval)ti {
  NSDate *internalDate = [NSDate dateWithTimeIntervalSinceReferenceDate:ti];
  return [self initWithDate:internalDate includesTimeComponent:YES];
}

- (NSTimeInterval)timeIntervalSinceReferenceDate {
  NSDate *internalDate = self.includesTimeComponent ? self.internalDate : self.internalDateWithoutTime;

  return internalDate.timeIntervalSinceReferenceDate;
}

#pragma mark - Properties

- (NSDate *)internalDateWithoutTime {
  @synchronized(self) {
    if (!_internalDateWithoutTime) {
      static NSCalendar *calendar = nil;
      
      static dispatch_once_t onceToken;
      dispatch_once(&onceToken, ^{
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        calendar.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
      });
      
      // If we should ignore time component, ignore all the time components of the date
      NSDateComponents *comps = [calendar components:(NSEraCalendarUnit |
                                                      NSYearCalendarUnit |
                                                      NSMonthCalendarUnit |
                                                      NSDayCalendarUnit) fromDate:self.internalDate];
      
      _internalDateWithoutTime = [calendar dateFromComponents:comps];
    }
    
    return _internalDateWithoutTime;
  }
}

#pragma mark - NSCoding

- (Class)classForCoder {
  return [self class];
}

+ (BOOL)supportsSecureCoding {
  return YES;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (!self) return nil;
  
  _internalDate = [[aDecoder decodeObjectOfClass:[NSDate class] forKey:kInternalDateKey] copy];
  _includesTimeComponent = [aDecoder decodeBoolForKey:kIncludesTimeComponentKey];
  
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.internalDate forKey:kInternalDateKey];
  [aCoder encodeBool:self.includesTimeComponent forKey:kIncludesTimeComponentKey];
  
  [super encodeWithCoder:aCoder];
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  return [[[self class] allocWithZone:zone] initWithDate:self.internalDate
                                   includesTimeComponent:self.includesTimeComponent];
}

@end
