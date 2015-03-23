//
//  PKTNotificationObjectFactory.m
//  PodioKit
//
//  Created by Romain Briche on 21/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKTNotificationObjectFactory.h"
#import "NSValueTransformer+PKTConstants.h"
#import "PKTConstants.h"
#import "PKTComment.h"
#import "PKTAppFieldConfig.h"
#import "PKTItemRevision.h"

@implementation PKTNotificationObjectFactory

+ (id)notificationObjectFromDictionary:(NSDictionary *)dictionary {
  PKTNotificationType type = [NSValueTransformer pkt_notificationTypeFromString:dictionary[@"type"]];
  NSDictionary *data = dictionary[@"data"];
  
  return [self notificationObjectFromData:data type:type];
}

+ (id)notificationObjectFromData:(NSDictionary *)data type:(NSUInteger)type {
  id obj = nil;
  
  Class klass = [self classForReferenceType:type];
  if (data && klass && [klass instancesRespondToSelector:@selector(initWithDictionary:)]) {
    obj = [[klass alloc] initWithDictionary:data];
  }
  
  return obj;
}

#pragma mark - Private

+ (Class)classForReferenceType:(PKTNotificationType)type {
  Class klass = nil;
  
  switch (type) {
    case PKTNotificationTypeComment:
      return [PKTComment class];
      break;
    case PKTNotificationTypeUpdate:
      return [PKTItemRevision class];
      break;
    case PKTNotificationTypeMemberReferenceAdd:
    case PKTNotificationTypeMemberReferenceRemove:
      return [PKTAppFieldConfig class];
      break;
    default:
      break;
  }
  
  return klass;
}

@end
