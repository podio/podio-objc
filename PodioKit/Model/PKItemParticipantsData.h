//
//  PKItemParticipantsData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 4/25/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKItemParticipantsData : PKObjectData

@property (nonatomic, copy, readonly) NSArray *invitedProfileIds;
@property (nonatomic, copy, readonly) NSArray *acceptedProfileIds;
@property (nonatomic, copy, readonly) NSArray *declinedProfileIds;
@property (nonatomic, copy, readonly) NSArray *tentativeProfileIds;

- (PKMeetingParticipantStatus)statusForProfileWithId:(NSUInteger)profileId;
- (void)setStatus:(PKMeetingParticipantStatus)status forProfileId:(NSUInteger)profileId;

@end
