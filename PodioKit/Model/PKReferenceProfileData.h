//
//  PKReferenceProfileData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/1/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"


@interface PKReferenceProfileData : PKObjectData {
  
@private
  NSInteger profileId_;
  NSInteger userId_;
  NSString *name_;
  NSInteger avatarId_;
}

@property (nonatomic) NSInteger profileId;
@property (nonatomic) NSInteger userId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) PKReferenceType type;
@property (nonatomic) NSInteger avatarId;

@end
