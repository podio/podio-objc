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

- (instancetype)initWithLabel:(NSString *)label
                  description:(NSString *)description
                     settings:(NSDictionary *)settings
                        delta:(NSUInteger)delta
                      mapping:(PKTAppFieldMapping)mapping
                   isRequired:(BOOL)isRequired
                    isVisible:(BOOL)isVisible {
  self = [super init];
  if (!self) return nil;

  _label = [label copy];
  _descr = [description copy];
  _settings = [settings copy];
  _delta = delta;
  _mapping = mapping;
  _required = isRequired;
  _visible = isVisible;

  return self;
}

#pragma mark - PKTModel

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