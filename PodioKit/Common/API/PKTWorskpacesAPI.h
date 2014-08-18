//
//  PKTWorskpacesAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 18/08/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"

typedef NS_ENUM(NSUInteger, PKTWorskpacePrivacy) {
  PKTWorskpacePrivacyDefault,
  PKTWorskpacePrivacyOpen,
  PKTWorskpacePrivacyClosed
};

@interface PKTWorskpacesAPI : PKTBaseAPI

+ (PKTRequest *)requestToCreateWorkspaceWithName:(NSString *)name organizationID:(NSUInteger)organization privacy:(PKTWorskpacePrivacy)privacy;

@end
