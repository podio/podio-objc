//
//  PKLinkedAccountAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/28/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKLinkedAccountAPI.h"

@implementation PKLinkedAccountAPI

+ (PKRequest *)requestForLinkedAccountsWithCapability:(PKProviderCapability)capability {
  PKRequest *request = [PKRequest requestWithURI:@"/linked_account/" method:PKRequestMethodGET];
  
  if (capability != PKProviderCapabilityNone) {
    [request.parameters setObject:[PKConstants stringForProviderCapability:capability] forKey:@"capability"];
  }
  
  return request;
}

+ (PKRequest *)requestForProvidersWithCapability:(PKProviderCapability)capability {
  PKRequest *request = [PKRequest requestWithURI:@"/linked_account/provider/" method:PKRequestMethodGET];
  
  if (capability != PKProviderCapabilityNone) {
    [request.parameters setObject:[PKConstants stringForProviderCapability:capability] forKey:@"capability"];
  }
  
  return request;
}

+ (PKRequest *)requestToCreateLinkedAccountWithBody:(NSDictionary *)body {
  PKRequest *request = [PKRequest requestWithURI:@"/linked_account/" method:PKRequestMethodPOST];
  request.body = body;
  
  return request;
}

@end
