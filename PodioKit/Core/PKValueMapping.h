//
//  PKValueMapping.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-04.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKPropertyMapping.h"

typedef enum {
  PKValueTypeNormal = 0,
  PKValueTypeDate,
  PKValueTypeUTCDate,
} PKValueType;

typedef id (^PKValueMappingBlock)(id attrVal, NSDictionary *objDict, id parent);

@interface PKValueMapping : PKPropertyMapping {
 
 @protected
  PKValueType valueType_;
  PKValueMappingBlock block_;
}

@property (nonatomic, assign) PKValueType valueType;
@property (nonatomic, copy) PKValueMappingBlock block;

- (id)initWithPropertyName:(NSString *)propertyName attributeName:(NSString *)attributeName block:(PKValueMappingBlock)block;

- (id)evaluateForValue:(id)attributeValue objectDict:(NSDictionary *)objectDict parent:(id)parent;

@end
