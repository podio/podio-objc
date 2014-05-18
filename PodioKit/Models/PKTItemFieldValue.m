//
//  PKTItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTItemFieldValue.h"
#import "NSArray+PKTAdditions.h"

NSString * const PKTItemFieldValueErrorDomain = @"PKTItemFieldValueErrorDomain";

@interface PKTItemFieldValue ()

@end

@implementation PKTItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super init];
  if (!self) return nil;
  
  return self;
}

#pragma mark - Properties

- (void)setUnboxedValue:(id)unboxedValue {
  [self setUnboxedValue:unboxedValue validate:YES];
}

- (void)setUnboxedValue:(id)unboxedValue validate:(BOOL)validate {
  if (validate) {
    [self validateUnboxedValue:unboxedValue];
  }
  
  _unboxedValue = unboxedValue;
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)object {
  BOOL equal = NO;
  
  if ([object isKindOfClass:[self class]] && self.unboxedValue) {
    PKTItemFieldValue *value = object;
    equal = [self.unboxedValue isEqual:value.unboxedValue];
  } else {
    equal = [super isEqual:object];
  }
  
  return equal;
}

- (NSUInteger)hash {
  return self.unboxedValue ? [self.unboxedValue hash] : [super hash];
}

#pragma mark - Public

- (NSDictionary *)valueDictionary {
  // Return nil by default, meaning it cannot be serialized back. e.g. calculation field
  return nil;
}

+ (BOOL)supportsBoxingOfValue:(id)value error:(NSError **)error {
  BOOL supported = YES;

  Class supportedClass = [self unboxedValueClass];
  if (supportedClass && ![value isKindOfClass:supportedClass]) {
    supported = NO;

    if (error) {
      NSString *message = [NSString stringWithFormat:@"Field value '%@' is not of expected class '%@' for value class '%@'.", value, NSStringFromClass(supportedClass), NSStringFromClass(self)];
      *error = [NSError errorWithDomain:PKTItemFieldValueErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey : message}];
    }
  }
  
  return supported;
}

+ (Class)unboxedValueClass {
  return nil;
}

#pragma mark - Private

- (void)validateUnboxedValue:(id)unboxedValue {
  NSError *error = nil;
  
  if (![[self class] supportsBoxingOfValue:unboxedValue error:&error]) {
    NSException *ex = [NSException exceptionWithName:@"PKTBoxingUnsupportedException"
                                              reason:[error localizedDescription]
                                            userInfo:nil];
    [ex raise];
  }
}

@end
