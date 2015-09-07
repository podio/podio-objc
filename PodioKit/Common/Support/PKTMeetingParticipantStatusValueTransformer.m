//
//  PKTMeetingParticipantStatusValueTransformer.m
//  PodioKit
//
//  Created by Lauge Jepsen on 07/09/2015.
//  Copyright © 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKTMeetingParticipantStatusValueTransformer.h"
#import "PKTConstants.h"

@implementation PKTMeetingParticipantStatusValueTransformer

- (instancetype)init {
  return [super initWithDictionary:@{
    @"invited": @(PKTMeetingParticipantStatusInvited),
    @"accepted": @(PKTMeetingParticipantStatusAccepted),
    @"declined": @(PKTMeetingParticipantStatusDeclined),
    @"tentative": @(PKTMeetingParticipantStatusTentative)
  }];
}

@end
