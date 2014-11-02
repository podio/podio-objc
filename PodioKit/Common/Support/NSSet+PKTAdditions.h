//
//  NSSet+PKTAdditions.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 29/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (PKTAdditions)

- (instancetype)pkt_mappedSetWithBlock:(id (^)(id obj))block;

- (instancetype)pkt_filteredSetWithBlock:(BOOL (^)(id obj))block;

@end
