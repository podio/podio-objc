//
//  PKReferenceItemData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/7/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKObjectData.h"

@interface PKReferenceItemData : PKObjectData {
  
@private
  NSInteger itemId_;
  NSString *title_;
  NSString *appName_;
  NSString *appItemName_;
}

@property (nonatomic) NSInteger itemId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSString *appItemName;

@end
