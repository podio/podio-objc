//
//  PKAttributeMapping.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/26/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/** A class describing how an attribute should be mapped to a specific domain object property.
 */
@interface PKAttributeMapping : NSObject {
  
@private
  NSArray *attributePathComponents_;
}

@property (nonatomic, strong) NSArray *attributePathComponents;
@property (nonatomic, readonly) NSString *attributePathComponentsString;

- (id)initWithAttributePathComponents:(NSArray *)attributePathComponents;

- (id)initWithAttributeName:(NSString *)attributeName;

+ (id)mappingForAttributePathComponents:(NSArray *)attributePathComponents;

+ (id)mappingForAttributeName:(NSString *)attributeName;

@end
