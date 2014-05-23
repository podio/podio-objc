//
//  PKTAppFieldConfig 
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/05/14
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

typedef NS_ENUM(NSUInteger, PKTAppFieldMapping) {
  PKTAppFieldMappingNone = 0,
  PKTAppFieldMappingMeetingTime,
  PKTAppFieldMappingMeetingParticipants,
  PKTAppFieldMappingMeetingAgenda,
  PKTAppFieldMappingMeetingLocation,
};

@interface PKTAppFieldConfig : PKTModel

@property (nonatomic, copy, readonly) NSString *label;
@property (nonatomic, copy, readonly) NSString *descr;
@property (nonatomic, copy, readonly) NSDictionary *settings;
@property (nonatomic, assign, readonly) NSUInteger delta;
@property (nonatomic, assign, readonly) PKTAppFieldMapping mapping;
@property (nonatomic, assign, readonly, getter = isRequired) BOOL required;
@property (nonatomic, assign, readonly, getter = isVisible) BOOL visible;

- (instancetype)initWithLabel:(NSString *)label description:(NSString *)description settings:(NSDictionary *)settings delta:(NSUInteger)delta mapping:(PKTAppFieldMapping)mapping isRequired:(BOOL)isRequired isVisible:(BOOL)isVisible;

@end