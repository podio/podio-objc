//
//  PKReferenceSpaceData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/21/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKReferenceSpaceData : PKObjectData {

 @private
  NSInteger spaceId_;
  PKSpaceType type_;
  NSString *name_;
}

@property (nonatomic) NSInteger spaceId;
@property (nonatomic) PKSpaceType type;
@property (nonatomic, copy) NSString *name;

@end
