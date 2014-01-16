//
//  PKItemFieldValueMoneyData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-07.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKObjectData.h"


@interface PKItemFieldValueMoneyData : PKObjectData {

 @private
  NSNumber *amount_;
  NSString *currency_;
}

@property (nonatomic, copy) NSNumber *amount;
@property (nonatomic, copy) NSString *currency;

@end
