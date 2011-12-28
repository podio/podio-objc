//
//  POStandaloneMapping.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/26/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKAttributeMapping.h"

@class PKObjectMapping;

typedef NSPredicate * (^POScopePredicateBlock)(id parentObject);

@interface PKStandaloneMapping : PKAttributeMapping {
  
 @protected
  PKObjectMapping *objectMapping_;       // The object mapping for the target entity
  POScopePredicateBlock scopePredicateBlock_;
}

@property (nonatomic, retain) PKObjectMapping *objectMapping;
@property (nonatomic, copy) POScopePredicateBlock scopePredicateBlock;

- (id)initWithAttributeName:(NSString *)attributeName 
              objectMapping:(PKObjectMapping *)objectMapping;

+ (id)mappingForAttributeName:(NSString *)attributeName 
                objectMapping:(PKObjectMapping *)objectMapping;

@end
