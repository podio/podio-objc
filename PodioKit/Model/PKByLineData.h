//
//  PKByLineData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/7/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKObjectData.h"
#import "PKFileData.h"

@interface PKByLineData : PKObjectData

@property (nonatomic) NSUInteger byId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) PKAvatarType avatarType;
@property (nonatomic) NSUInteger avatarId;
@property (nonatomic, strong) PKFileData *avatarImage;

@end
