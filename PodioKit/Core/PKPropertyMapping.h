//
//  PKPropertyMapping.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-04.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKAttributeMapping.h"


@interface PKPropertyMapping : PKAttributeMapping {

 @protected
  NSString *propertyName_;
}

@property (nonatomic, copy) NSString *propertyName;

- (id)initWithPropertyName:(NSString *)propertyName attributeName:(NSString *)attributeName;

- (id)initWithPropertyName:(NSString *)propertyName attributePathComponents:(NSArray *)attributePathComponents;

+ (id)mappingForPropertyName:(NSString *)propertyName attributeName:(NSString *)attributeName;

+ (id)mappingForPropertyName:(NSString *)propertyName attributePathComponents:(NSArray *)attributePathComponents;

@end
