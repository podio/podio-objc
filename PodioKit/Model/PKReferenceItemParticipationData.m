//
//  PKReferenceItemParticipationData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 20/02/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKReferenceItemParticipationData.h"

static NSString * const PKReferenceItemParticipationDataStatus = @"Status";

@implementation PKReferenceItemParticipationData

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (!self) return nil;
  
  _status = [aDecoder decodeIntegerForKey:PKReferenceItemParticipationDataStatus];
  
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  
  [aCoder encodeInteger:_status forKey:PKReferenceItemParticipationDataStatus];
}

#pragma mark - PKObjectData

+ (instancetype)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceItemParticipationData *data = [self data];
  
  data.status = [PKConstants meetingParticipantStatusForString:[dict pk_objectForKey:@"status"]];
  
  return data;
}

@end
