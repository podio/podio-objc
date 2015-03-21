//
//  NSValueTransformer+PKTTransformers.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 15/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTBlockValueTransformer.h"

@interface NSValueTransformer (PKTTransformers)

+ (NSValueTransformer *)pkt_transformerWithBlock:(PKTValueTransformationBlock)block;
+ (NSValueTransformer *)pkt_transformerWithBlock:(PKTValueTransformationBlock)block reverseBlock:(PKTValueTransformationBlock)reverseBlock;
+ (NSValueTransformer *)pkt_transformerWithModelClass:(Class)modelClass;

+ (NSValueTransformer *)pkt_transformerWithDictionary:(NSDictionary *)dictionary;
+ (NSValueTransformer *)pkt_URLTransformer;
+ (NSValueTransformer *)pkt_dateValueTransformer;
+ (NSValueTransformer *)pkt_referenceTypeTransformer;
+ (NSValueTransformer *)pkt_notificationTypeTransformer;
+ (NSValueTransformer *)pkt_appFieldTypeTransformer;
+ (NSValueTransformer *)pkt_numberValueTransformer;
+ (NSValueTransformer *)pkt_rightValueTransformer;

@end
