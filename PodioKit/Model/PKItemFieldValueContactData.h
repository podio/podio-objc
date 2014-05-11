//
//  PKItemFieldValueContactData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-07.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKObjectData.h"


@interface PKItemFieldValueContactData : PKObjectData

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *organization;
@property NSInteger userId;
@property NSInteger profileId;
@property NSInteger avatarId;

@end
