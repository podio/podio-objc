//
//  PKStreamItemData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"


@interface PKStreamItemData : PKObjectData {

 @private
  NSInteger itemId_;
  NSString *title_;
}

@property (nonatomic) NSInteger itemId;
@property (nonatomic, copy) NSString *title;

@end
