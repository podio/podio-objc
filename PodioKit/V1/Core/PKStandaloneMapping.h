//
//  PKStandaloneMapping.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/26/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKAttributeMapping.h"

@class PKObjectMapping;

typedef NSPredicate * (^PKScopePredicateBlock)(id parentObject);

@interface PKStandaloneMapping : PKAttributeMapping {
  
 @protected
  PKObjectMapping *objectMapping_;       // The object mapping for the target entity
  PKScopePredicateBlock scopePredicateBlock_;
}

@property (nonatomic, strong) PKObjectMapping *objectMapping;
@property (nonatomic, copy) PKScopePredicateBlock scopePredicateBlock;

- (id)initWithAttributeName:(NSString *)attributeName 
              objectMapping:(PKObjectMapping *)objectMapping;

+ (id)mappingForAttributeName:(NSString *)attributeName 
                objectMapping:(PKObjectMapping *)objectMapping;

@end
