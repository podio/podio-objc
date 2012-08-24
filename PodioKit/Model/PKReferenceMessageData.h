//
//  PKReferenceMessageData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/7/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKReferenceMessageData : PKObjectData {
  
@private
  NSInteger messageId_;
  NSString *text_;
  BOOL isReply_;
}

@property (nonatomic) NSInteger messageId;
@property (nonatomic, copy) NSString *text;
@property (nonatomic) BOOL isReply;

@end
