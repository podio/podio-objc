//
//  PKSpaceMemberRequestData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/29/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKObjectData.h"

@interface PKSpaceMemberRequestData : PKObjectData

@property (nonatomic) NSUInteger requestId;
@property (nonatomic) NSUInteger spaceId;
@property (nonatomic) PKSpaceMemberRequestStatus status;

@end
