//
//  PKItemFieldValueEmailData.h
//  PodioKit
//
//  Created by Pavel Prochazka on 08/06/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKObjectData.h"

@interface PKItemFieldValueEmailData : PKObjectData{
  
@private
  NSString    *email_;
  PKEmailType type_;
}

@property (nonatomic, copy) NSString *email;
@property (nonatomic) PKEmailType     type;
@property (nonatomic, copy, readonly) NSDictionary *valueDictionary;

@end