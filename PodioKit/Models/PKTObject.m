//
//  PKTObject.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 31/03/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTObject.h"

static PKTClient *sClient = nil;

@implementation PKTObject

+ (PKTClient *)client {
  @synchronized(self) {
    PKTClient *client = nil;
    
    if (sClient) {
      client = sClient;
    } else {
      client = [PKTClient sharedClient];
    }
    
    return client;
  }
}

+ (void)setClient:(PKTClient *)client {
  @synchronized(self) {
    sClient = client;
  }
}

@end
