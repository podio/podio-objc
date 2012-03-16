//
//  PKLinkedAccountAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/28/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKLinkedAccountAPI.h"

@implementation PKLinkedAccountAPI

+ (PKRequest *)requestForLinkedAccountsWithCapability:(PKProviderCapability)capability {
  PKRequest *request = [PKRequest requestWithURI:@"/linked_account/" method:PKAPIRequestMethodGET];
  
  if (capability != PKProviderCapabilityNone) {
    [request.parameters setObject:[PKConstants stringForProviderCapability:capability] forKey:@"capability"];
  }
  
  return request;
}

+ (PKRequest *)requestForProvidersWithCapability:(PKProviderCapability)capability {
  PKRequest *request = [PKRequest requestWithURI:@"/linked_account/provider/" method:PKAPIRequestMethodGET];
  
  if (capability != PKProviderCapabilityNone) {
    [request.parameters setObject:[PKConstants stringForProviderCapability:capability] forKey:@"capability"];
  }
  
  return request;
}

@end
