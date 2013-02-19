//
//  PKSpaceInviteData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2013-02-19.
//  Copyright (c) 2013 Citrix Systems, Inc. All rights reserved.
//

#import "PKSpaceInviteData.h"

static NSString * const PKSpaceInviteDataInviteCode = @"InviteCode";
static NSString * const PKSpaceInviteDataMessage = @"Message";

@implementation PKSpaceInviteData

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _inviteCode = [[aDecoder decodeObjectForKey:PKSpaceInviteDataInviteCode] copy];
    _message = [[aDecoder decodeObjectForKey:PKSpaceInviteDataMessage] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:_inviteCode forKey:PKSpaceInviteDataInviteCode];
  [aCoder encodeObject:_message forKey:PKSpaceInviteDataMessage];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKSpaceInviteData *data = [self data];
  
  data.inviteCode = [dict pk_objectForKey:@"invite_code"];
  data.message = [dict pk_objectForKey:@"message"];
  
  return data;
}

@end
