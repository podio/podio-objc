//
//  POSyncAttributeMapping.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-04.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKPropertyMapping.h"

typedef id (^PKValueMappingBlock)(id attrVal, NSDictionary *objDict, id parent);

@interface PKValueMapping : PKPropertyMapping {
 
 @protected
  PKValueMappingBlock block_;
}

@property (nonatomic, copy) PKValueMappingBlock block;

- (id)initWithPropertyName:(NSString *)propertyName attributeName:(NSString *)attributeName block:(PKValueMappingBlock)block;

- (id)evaluateForValue:(id)attributeValue objectDict:(NSDictionary *)objectDict parent:(id)parent;

@end
