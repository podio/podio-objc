//
//  PKTItemField(PKTTest) 
//  PodioKit
//
//  Created by Sebastian Rehnby on 18/05/14
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "PKTItemField.h"

@interface PKTItemField (PKTTest)

+ (Class)valueClassForFieldType:(PKTAppFieldType)fieldType;

+ (id)unboxedValueFromBasicValue:(id)value forField:(PKTAppField *)field;

@end