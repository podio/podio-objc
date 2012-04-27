//
//  PKItemParticipantsData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 4/25/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKItemParticipantsData.h"


static NSString * const PKItemParticipantsDataParticipantsDictKey = @"ParticipantsDict";

@interface PKItemParticipantsData ()

@property (nonatomic, strong) NSMutableDictionary *participantsDict;

- (NSArray *)profileIdsWithStatus:(PKMeetingParticipantStatus)status;

@end

@implementation PKItemParticipantsData

@synthesize participantsDict = participantsDict_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    participantsDict_ = [aDecoder decodeObjectForKey:PKItemParticipantsDataParticipantsDictKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:participantsDict_ forKey:PKItemParticipantsDataParticipantsDictKey];
}

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemParticipantsData *data = [self data];
  
  data.participantsDict = [[NSMutableDictionary alloc] initWithCapacity:[dict count]];
  
  [dict enumerateKeysAndObjectsUsingBlock:^(id profileIdString, id statusDict, BOOL *stop) {
    NSNumber *profileId = [NSNumber numberWithInteger:[profileIdString integerValue]];
    [data.participantsDict setObject:[statusDict pk_objectForKey:@"status"] forKey:profileId];
  }];
  
  return data;
}


#pragma mark - Helpers

- (NSArray *)invitedProfileIds {
  return [self profileIdsWithStatus:PKMeetingParticipantStatusInvited];
}

- (NSArray *)acceptedProfileIds {
  return [self profileIdsWithStatus:PKMeetingParticipantStatusAccepted];  
}

- (NSArray *)declinedProfileIds {
  return [self profileIdsWithStatus:PKMeetingParticipantStatusDeclined];
}

- (NSArray *)tentativeProfileIds {
  return [self profileIdsWithStatus:PKMeetingParticipantStatusTentative];
}

- (NSArray *)profileIdsWithStatus:(PKMeetingParticipantStatus)status {
  NSMutableArray *mutProfileIds = [[NSMutableArray alloc] init];
  
  NSString *statusString = [PKConstants stringForMeetingParticipantStatus:status];
  
  [self.participantsDict enumerateKeysAndObjectsUsingBlock:^(id key, id status, BOOL *stop) {
    if ([status isEqualToString:statusString]) {
      [mutProfileIds addObject:key];
    }
  }];
  
  return [mutProfileIds copy];
}

- (PKMeetingParticipantStatus)statusForProfileWithId:(NSUInteger)profileId {
  PKMeetingParticipantStatus status = PKMeetingParticipantStatusNone;
  
  NSString *statusString = [self.participantsDict pk_objectForKey:[NSNumber numberWithUnsignedInteger:profileId]];
  if (statusString != nil) {
    status = [PKConstants meetingParticipantStatusForString:statusString];
  }
  
  return status;
}

- (void)setStatus:(PKMeetingParticipantStatus)status forProfileId:(NSUInteger)profileId {
  NSString *statusString = [PKConstants stringForMeetingParticipantStatus:status];
  [self.participantsDict setObject:statusString forKey:[NSNumber numberWithUnsignedInteger:profileId]];
}

@end
