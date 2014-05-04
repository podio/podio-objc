//
//  PKTItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTItemFieldValue.h"

NSString * const PKTItemFieldValueErrorDomain = @"PKTItemFieldValueErrorDomain";

@interface PKTItemFieldValue ()

@end

@implementation PKTItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super init];
  if (!self) return nil;
  
  return self;
}

+ (instancetype)valueFromDictionary:(NSDictionary *)valueDictionary {
  return [[self alloc] initFromValueDictionary:valueDictionary];
}

- (NSDictionary *)valueDictionary {
  // Return nil by default, meaning it cannot be serialized back. e.g. calculation field
  return nil;
}

- (void)setUnboxedValue:(id)unboxedValue {
  [self raiseBoxingUnsupportedException];
}

- (id)unboxedValue {
  [self raiseBoxingUnsupportedException];
  return nil;
}

+ (BOOL)supportsBoxingOfValue:(id)value {
  return NO;
}

+ (BOOL)supportsBoxingOfValue:(id)value error:(NSError **)error {
  BOOL supported = [self supportsBoxingOfValue:value];
  
  if (!supported) {
    NSString *message = [NSString stringWithFormat:@"Value %@ not supported for class '%@'", value, NSStringFromClass(self)];
    *error = [NSError errorWithDomain:PKTItemFieldValueErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey : message}];
  }
  
  return supported;
}

#pragma mark - Private

- (void)raiseBoxingUnsupportedException {
  NSString *reason = [NSString stringWithFormat:@"Boxing support not implemented for class: %@", [self class]];
  [NSException exceptionWithName:@"BoxingUnsupportedException" reason:reason userInfo:nil];
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

@end
