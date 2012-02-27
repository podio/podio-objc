//
//  PKAttributeMapping.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/26/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>

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
