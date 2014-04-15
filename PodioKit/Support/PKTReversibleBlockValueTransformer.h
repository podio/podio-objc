//
//  PKTReversibleBlockValueTransformer.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBlockValueTransformer.h"

@interface PKTReversibleBlockValueTransformer : PKTBlockValueTransformer

- (instancetype)initWithBlock:(PKTValueTransformationBlock)block reverseBlock:(PKTValueTransformationBlock)reverseBlock;

+ (instancetype)transformerWithBlock:(PKTValueTransformationBlock)block reverseBlock:(PKTValueTransformationBlock)reverseBlock;

@end
