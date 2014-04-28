//
//  PKTMoneyItemFieldValue.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTItemFieldValue.h"

@interface PKTMoneyItemFieldValue : PKTItemFieldValue

@property (nonatomic, copy) NSNumber *value;
@property (nonatomic, copy) NSString *currency;

@end
