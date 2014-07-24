//
//  PKReferenceItemData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/7/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKReferenceItemData : PKObjectData {
  
@private
  NSInteger itemId_;
  NSString *title_;
  NSString *appName_;
  NSNumber *appId_;
  NSString *appItemName_;
  NSString *appIcon_;
}

@property (nonatomic) NSInteger itemId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSNumber *appId;
@property (nonatomic, copy) NSString *appItemName;
@property (nonatomic, copy) NSString *appIcon;

@end
