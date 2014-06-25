//
//  NSValueTransformer+PKTConstants.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTConstants.h"

@interface NSValueTransformer (PKTConstants)

+ (PKTReferenceType)pkt_referenceTypeFromString:(NSString *)string;
+ (NSString *)pkt_stringFromReferenceType:(PKTReferenceType)referenceType;

@end
