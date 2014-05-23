//
//  PKTItemField.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTAppField.h"

@interface PKTItemField : PKTAppField

@property (nonatomic, strong) id value; // The unboxed value
@property (nonatomic, copy) NSArray *values; // The unboxed values

- (instancetype)initWithAppField:(PKTAppField *)appField basicValues:(NSArray *)basicValues;

+ (BOOL)isSupportedValue:value forFieldType:(PKTAppFieldType)fieldType error:(NSError **)error;

- (void)addValue:(id)value;

- (void)removeValue:(id)value;
- (void)removeValueAtIndex:(NSUInteger)index;

- (NSArray *)preparedValues;

@end
