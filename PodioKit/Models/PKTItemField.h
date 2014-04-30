//
//  PKTItemField.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTAppField.h"

@interface PKTItemField : PKTAppField

@property (nonatomic, copy, readonly) NSArray *values;

- (instancetype)initWithAppField:(PKTAppField *)appField values:(NSArray *)values;

- (id)valueAtIndex:(NSUInteger)index;
- (id)firstValue;

- (void)setValues:(NSArray *)values;
- (void)setFirstValue:(id)value;
- (void)addValue:(id)value;

- (void)removeValue:(id)value;
- (void)removeValueAtIndex:(NSUInteger)index;

- (NSArray *)preparedValues;

@end
