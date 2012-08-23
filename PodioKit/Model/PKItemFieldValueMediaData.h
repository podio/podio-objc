//
//  PKItemFieldValueMediaData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/19/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKObjectData.h"


@interface PKItemFieldValueMediaData : PKObjectData {

 @private
  NSString *embedCode_;
  NSString *provider_;
  NSString *videoId_;
}

@property (nonatomic, copy) NSString *embedCode;
@property (nonatomic, copy) NSString *provider;
@property (nonatomic, copy) NSString *videoId;

@end
