//
//  PKSearchResultData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/3/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKObjectData.h"

@interface PKSearchResultData : PKObjectData

@property (nonatomic) PKReferenceType referenceType;
@property (nonatomic) NSInteger referenceId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *appName;
@property (nonatomic, copy) NSString *appItemName;
@property (nonatomic, copy) NSString *appIcon;
@property (nonatomic) NSInteger spaceId;
@property (nonatomic, copy) NSString *spaceName;

@end
