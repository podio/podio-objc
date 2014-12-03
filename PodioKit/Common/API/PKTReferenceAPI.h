//
//  PKTReferenceAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/12/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"

typedef NS_ENUM(NSUInteger, PKTReferenceTarget) {
  PKTReferenceTargetTaskReference,
  PKTReferenceTargetTaskResponsible,
  PKTReferenceTargetAlert,
  PKTReferenceTargetConversation,
  PKTReferenceTargetConversationPresence,
  PKTReferenceTargetGrant,
  PKTReferenceTargetItemField,
  PKTReferenceTargetItemCreatedBy,
  PKTReferenceTargetItemCreatedVia,
  PKTReferenceTargetItemTags,
  PKTReferenceTargetGlobalNav,
  PKTReferenceTargetScriptVariables,
  PKTReferenceTargetApps,
  PKTReferenceTargetInvite
};

@interface PKTReferenceAPI : PKTBaseAPI

+ (PKTRequest *)requestToSearchForReferenceWithText:(NSString *)text target:(PKTReferenceTarget)target targetParameters:(NSDictionary *)targetParamers limit:(NSUInteger)limit;

@end
