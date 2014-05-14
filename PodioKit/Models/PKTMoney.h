//
//  PKTMoney.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@interface PKTMoney : PKTModel

@property (nonatomic, copy) NSNumber *amount;
@property (nonatomic, copy) NSString *currency;

- (instancetype)initWithAmount:(NSNumber *)amount currency:(NSString *)currency;

@end
