//
//  PKTBlockValueTransformer.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef id (^PKTValueTransformationBlock) (id value);

@interface PKTBlockValueTransformer : NSValueTransformer

- (instancetype)initWithBlock:(PKTValueTransformationBlock)block;

+ (instancetype)transformerWithBlock:(PKTValueTransformationBlock)block;

@end
