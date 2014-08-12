//
//  NSArray+PKTAdditions.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 01/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (PKTAdditions)

- (NSArray *)pkt_mappedArrayWithBlock:(id (^)(id obj))block;
- (NSArray *)pkt_filteredArrayWithBlock:(BOOL (^)(id obj))block;
- (id)pkt_firstObjectPassingTest:(BOOL (^)(id obj))block;
+ (NSArray *)pkt_arrayFromRange:(NSRange)range;

@end
