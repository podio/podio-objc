//
//  PKItemFieldValuePhoneData.h
//  PodioKit
//
//  Created by Pavel Prochazka on 08/06/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKObjectData.h"

@interface PKItemFieldValuePhoneData : PKObjectData{
  
@private
  NSString    *number_;
  PKPhoneType type_;
}

@property (nonatomic, copy) NSString *number;
@property (nonatomic) PKPhoneType  type;
@property (nonatomic, copy, readonly) NSDictionary *valueDictionary;

@end