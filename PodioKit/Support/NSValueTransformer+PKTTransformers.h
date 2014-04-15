//
//  NSValueTransformer+PKTTransformers.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 15/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTBlockValueTransformer.h"
#import "PKTReversibleBlockValueTransformer.h"
#import "PKTModelValueTransformer.h"

@interface NSValueTransformer (PKTTransformers)

+ (NSValueTransformer *)pkt_transformerWithBlock:(PKTValueTransformationBlock)block;
+ (NSValueTransformer *)pkt_transformerWithBlock:(PKTValueTransformationBlock)block reverseBlock:(PKTValueTransformationBlock)reverseBlock;
+ (NSValueTransformer *)pkt_transformerWithModelClass:(Class)modelClass;

@end
