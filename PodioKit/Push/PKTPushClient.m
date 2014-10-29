//
//  PKTPushClient.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <DDCometClient/DDCometClient.h>
#import "PKTPushClient.h"

static NSString * const kDefaultEndpointURLString = @"https://push.podio.com/faye";

@interface PKTPushClient () <DDCometClientDelegate>

@property (nonatomic, strong) DDCometClient *client;

@end

@implementation PKTPushClient

+ (PKTPushClient *)sharedClient {
  static id sharedClient;
  static dispatch_once_t once;
  
  dispatch_once(&once, ^{
    sharedClient = [[self alloc] initWithEndpointURL:[NSURL URLWithString:kDefaultEndpointURLString]];
  });
  
  return sharedClient;
}

- (instancetype)initWithEndpointURL:(NSURL *)url {
  NSParameterAssert(url);
  
  self = [super init];
  if (!self) return nil;
  
  _client = [[DDCometClient alloc] initWithURL:url];
  _client.delegate = self;
  
  return self;
}

#pragma mark - Public


- (PKTPushSubscription *)subscribeWithCredential:(PKTPushCredential *)credential eventBlock:(void (^)(PKTPushEvent *event))block {
  [self.client scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
  [self.client handshake];
  
  return nil;
}

- (void)unsubscribe:(PKTPushSubscription *)subscription {
}

#pragma mark - DDCometClientDelegate

- (void)cometClientConnectDidSucceed:(DDCometClient *)client {

}

- (void)cometClient:(DDCometClient *)client connectDidFailWithError:(NSError *)error {

}

- (void)cometClientHandshakeDidSucceed:(DDCometClient *)client {

}

- (void)cometClient:(DDCometClient *)client handshakeDidFailWithError:(NSError *)error {
  
}

- (void)cometClient:(DDCometClient *)client subscriptionDidSucceed:(DDCometSubscription *)subscription {
  
}

- (void)cometClient:(DDCometClient *)client subscription:(DDCometSubscription *)subscription didFailWithError:(NSError *)error {

}

@end
