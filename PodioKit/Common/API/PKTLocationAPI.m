//
//  PKTLocationAPI.m
//  PodioKit
//
//  Created by Lauge Jepsen on 04/11/2015.
//  Copyright © 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKTLocationAPI.h"

@implementation PKTLocationAPI

+ (PKTRequest *)requestToLookupLoactionWithAddressString:(NSString *)address {
  NSDictionary *params = @{@"address": address};
  return [PKTRequest GETRequestWithPath:@"/location/lookup" parameters:params];
}

@end
