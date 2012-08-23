//
//  PKCompoundMapping.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/26/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
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
