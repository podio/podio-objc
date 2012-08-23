//
//  PKAppFieldMoneyData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 8/22/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKAppFieldMoneyData : PKObjectData {
  
 @private
  NSArray *allowedCurrencies_;
}

@property (nonatomic, strong) NSArray *allowedCurrencies;

@end
