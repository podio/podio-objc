//
//  PKTItemField.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"
#import "PKTAppField.h"

@interface PKTItemField : PKTModel

@property (nonatomic, assign, readonly) NSUInteger fieldID;
@property (nonatomic, copy, readonly) NSString *externalID;
@property (nonatomic, assign, readonly) PKTAppFieldType type;
@property (nonatomic, copy, readonly) NSArray *values;

- (id)valueAtIndex:(NSUInteger)index;
- (id)firstValue;

- (void)setValues:(NSArray *)values;
- (void)setFirstValue:(id)value;
- (void)addValue:(id)value;

- (void)removeValue:(id)value;
- (void)removeValueAtIndex:(NSUInteger)index;

- (NSArray *)preparedValues;

@end
