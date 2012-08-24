//
//  PKExternalMeetingData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/7/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKExternalMeetingData : PKObjectData

@property (nonatomic) PKExternalMeetingType type;
@property (nonatomic, copy) id externalId;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *url;

@end
