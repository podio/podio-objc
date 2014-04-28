//
//  PKTItemFieldValue.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"
#import "PKTAppField.h"

@interface PKTItemFieldValue : PKTModel

+ (instancetype)valueWithType:(PKTAppFieldType)type valueDictionary:(NSDictionary *)valueDictionary;

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary;

+ (instancetype)valueFromDictionary:(NSDictionary *)valueDictionary;

- (NSDictionary *)valueDictionary;

@end
