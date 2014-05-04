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

@property (nonatomic, strong) id unboxedValue;

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary;

- (NSDictionary *)valueDictionary;

+ (BOOL)supportsBoxingOfValue:(id)value error:(NSError **)error;

+ (BOOL)supportsBoxingOfValue:(id)value;

@end
