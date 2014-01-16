//
//  PKItemFieldValueOptionData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 8/23/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"


@interface PKItemFieldValueOptionData : PKObjectData {

 @private
  NSInteger optionId_;
  NSString *text_;
  BOOL selected_;
}

@property NSInteger optionId;
@property (nonatomic, copy) NSString *text;
@property BOOL selected;
@property (nonatomic, copy) NSString *colorString;

- (BOOL)isEqualToOption:(PKItemFieldValueOptionData *)option;

@end
