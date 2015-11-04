//
//  PKTLocationAPI.h
//  PodioKit
//
//  Created by Lauge Jepsen on 04/11/2015.
//  Copyright © 2015 Citrix Systems, Inc. All rights reserved.
//

#import <PodioKit/PodioKit.h>

@interface PKTLocationAPI : PKTBaseAPI

+ (PKTRequest *)requestToLookupLoactionWithAddressString:(NSString *)address;

@end
