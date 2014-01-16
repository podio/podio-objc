//
//  PKStreamActivityCommentData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKReferenceCommentData : PKObjectData {

 @private
  NSInteger commentId_;
  NSString *value_;
}

@property (nonatomic) NSInteger commentId;
@property (nonatomic, copy) NSString *value;

@end
