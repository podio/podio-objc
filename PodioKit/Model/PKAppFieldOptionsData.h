//
//  PKAppFieldOptionsData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 8/17/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKAppFieldOptionsData : PKObjectData {

 @private
  BOOL multiple_;
  NSArray *options_; // Array of PKItemFieldValueOptionData
}

@property BOOL multiple;
@property (nonatomic, strong) NSArray *options;

@end
