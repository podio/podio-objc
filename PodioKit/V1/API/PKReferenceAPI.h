//
//  PKReferenceAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/8/13.
//  Copyright (c) 2013 Citrix Systems, Inc. All rights reserved.
//

#import "PKBaseAPI.h"

typedef NS_ENUM(NSUInteger, PKReferenceTarget) {
  PKReferenceTargetTaskReference,
  PKReferenceTargetTaskResponsible,
  PKReferenceTargetAlert,
  PKReferenceTargetConversation,
  PKReferenceTargetConversationPresence,
  PKReferenceTargetGrant,
  PKReferenceTargetItemField,
  PKReferenceTargetItemCreatedBy,
  PKReferenceTargetItemCreatedVia,
  PKReferenceTargetItemTags,
  PKReferenceTargetGlobalNav,
};

@interface PKReferenceAPI : PKBaseAPI

+ (PKRequest *)requestToSearchReferenceWithTarget:(PKReferenceTarget)target targetParameters:(NSDictionary *)targetParameters query:(NSString *)query limit:(NSUInteger)limit;

+ (PKRequest *)requestToResolveURLString:(NSString *)URLString;

@end
