//
//  PKTItemFieldValue.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"
#import "PKTAppField.h"

extern NSString * const PKTItemFieldValueErrorDomain;

@interface PKTItemFieldValue : PKTModel

@property (nonatomic, strong) id unboxedValue; // The underlying value object. Its type will depend on the field type.

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary;

- (void)setUnboxedValue:(id)unboxedValue validate:(BOOL)validate;

+ (BOOL)supportsBoxingOfValue:(id)value error:(NSError **)error;

/** Override in subclass to return the expected unboxed value type */
+ (Class)unboxedValueClass;

/** Override in subclass to serialize the boxed value into a dictionary to be saved as the field value */
- (NSDictionary *)valueDictionary;

@end
