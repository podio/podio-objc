//
//  PKTAppFieldConfig 
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/05/14
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//


#import "PKTAppFieldConfig.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTAppFieldConfig

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
  return [super initWithDictionary:dictionary];
}

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"descr" : @"description",
  };
}

+ (NSValueTransformer *)mappingValueTransformer {
  return [NSValueTransformer pkt_transformerWithDictionary:@{
     @"meeting_time" : @(PKTAppFieldMappingMeetingTime),
     @"meeting_participants" : @(PKTAppFieldMappingMeetingParticipants),
     @"meeting_agenda" : @(PKTAppFieldMappingMeetingAgenda),
     @"meeting_location" : @(PKTAppFieldMappingMeetingLocation),
  }];
}

@end