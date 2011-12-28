//
//  POAppItemFieldAppItemData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-07.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKObjectData.h"


@interface PKItemFieldValueItemData : PKObjectData {

@private
  NSInteger itemId_;
  NSString *title_;
  NSInteger appId_;
  NSString *appName_;
  NSString *appIcon_;
}

@property NSInteger itemId;
@property (nonatomic, copy) NSString *title;

@property NSInteger appId;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSString *appIcon;

@end
