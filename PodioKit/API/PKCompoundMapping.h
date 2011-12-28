//
//  POCompoundMapping.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/26/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKAttributeMapping.h"

@interface PKCompoundMapping : PKAttributeMapping {

 @private
  NSMutableArray *mappings_;
}

@property (nonatomic, readonly) NSArray *mappings;

- (void)addMapping:(id)mapping;

@end
