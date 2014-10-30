//
//  PKTPushClient.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <DDCometClient/DDCometClient.h>
#import <DDCometClient/DDCometSubscription.h>
#import <DDCometClient/DDCometMessage.h>
#import "PKTPushClient.h"
#import "PKTMacros.h"
#import "NSSet+PKTAdditions.h"

#pragma mark - PKTPushClient

typedef NS_ENUM(NSUInteger, PKTPushSubscriptionState) {
  PKTPushSubscriptionStateInactive,
  PKTPushSubscriptionStateSubscribing,
  PKTPushSubscriptionStateActive
};

@interface PKTInternalPushSubscription : NSObject

@property (nonatomic, copy, readonly) NSString *channel;
@property (nonatomic, copy, readonly) NSDictionary *extensions;
@property (nonatomic, copy, readonly) PKTPushEventBlock eventBlock;
@property (nonatomic) PKTPushSubscriptionState state;
@property (nonatomic, weak, readonly) PKTPushClient *client;

@end

#pragma mark - PKTInternalPushSubscription

@implementation PKTInternalPushSubscription

- (instancetype)initWithChannel:(NSString *)channel extensions:(NSDictionary *)extensions client:(PKTPushClient *)client eventBlock:(PKTPushEventBlock)eventBlock {
  NSParameterAssert(eventBlock);
  
  self = [super init];
  if (!self) return nil;
  
  _channel = [channel copy];
  _extensions = [extensions copy];
  _eventBlock = [eventBlock copy];
  _state = PKTPushSubscriptionStateInactive;
  _client = client;
  
  return self;
}

- (void)deliverMessage:(DDCometMessage *)message {
  PKTPushEvent *event = [[PKTPushEvent alloc] initWithDictionary:message.data];
  self.eventBlock(event);
}

#pragma mark - NSObject

- (BOOL)isEqual:(id)other {
  if (other == self) {
    return YES;
  } else if (![super isEqual:other]) {
    return NO;
  } else if (![other isKindOfClass:[self class]]) {
    return NO;
  } else {
    return [self.channel isEqualToString:[(PKTInternalPushSubscription *)other channel]];
  }
}

- (NSUInteger)hash {
  return [self.channel hash];
}

@end

#pragma mark - PKTPushSubscription

@interface PKTPushSubscription ()

@property (nonatomic, weak, readonly) PKTInternalPushSubscription *internalSubscription;

@end

@implementation PKTPushSubscription

- (instancetype)initWithInternalSubscription:(PKTInternalPushSubscription *)subscription {
  self = [super init];
  if (!self) return nil;
  
  _internalSubscription = subscription;
  
  return self;
}

+ (instancetype)subscriptionForInternalSubscription:(PKTInternalPushSubscription *)subscription {
  return [[self alloc] initWithInternalSubscription:subscription];
}

- (void)unsubscribe {
  [self.internalSubscription.client unsubscribe:self];
}

@end

#pragma mark - PKTPushClient

static NSString * const kDefaultEndpointURLString = @"https://push.podio.com/faye";

@interface PKTPushClient () <DDCometClientDelegate>

@property (nonatomic, strong) DDCometClient *client;

@property (nonatomic, readonly, getter=isDisonnected) BOOL disconnected;
@property (nonatomic, readonly, getter=isConnecting) BOOL connecting;
@property (nonatomic, readonly, getter=isConnected) BOOL connected;
@property (nonatomic, readonly, getter=isDisconnecting) BOOL disconnecting;

@property (nonatomic, strong) NSMutableSet *subscriptions;
@property (nonatomic, copy) NSSet *inactiveSubscriptions;
@property (nonatomic, copy) NSSet *activeSubscriptions;
@property (nonatomic, copy) NSSet *subscribingSubscriptions;

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
  _subscriptions = [NSMutableSet new];
  
  return self;
}

#pragma mark - Properties

- (BOOL)isDisconnected {
  return self.client.state == DDCometStateDisconnected;
}

- (BOOL)isConnecting {
  return self.client.state == DDCometStateConnecting;
}

- (BOOL)isConnected {
  return self.client.state == DDCometStateConnected;
}

- (BOOL)isDisconnecting {
  return self.client.state == DDCometStateDisconnecting;
}

- (NSSet *)inactiveSubscriptions {
  return [self.subscriptions pkt_filteredSetWithBlock:^BOOL(PKTInternalPushSubscription *subscription) {
    return subscription.state == PKTPushSubscriptionStateInactive;
  }];
}

- (NSSet *)activeSubscriptions {
  return [self.subscriptions pkt_filteredSetWithBlock:^BOOL(PKTInternalPushSubscription *subscription) {
    return subscription.state == PKTPushSubscriptionStateActive;
  }];
}

- (NSSet *)subscribingSubscriptions {
  return [self.subscriptions pkt_filteredSetWithBlock:^BOOL(PKTInternalPushSubscription *subscription) {
    return subscription.state == PKTPushSubscriptionStateSubscribing;
  }];
}

#pragma mark - Private

- (void)connect {
  if (self.isConnected || self.isConnecting) {
    return;
  }
  
  [self.client scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
  [self.client handshake];
}

- (void)disconnect {
  if (self.isDisonnected || self.isDisconnecting) {
    return;
  }
  
  [self.client disconnect];
}

- (void)addSubscription:(PKTInternalPushSubscription *)subscription {
  NSParameterAssert(subscription);
  [self.subscriptions addObject:subscription];

  [self resubscribeToInactiveSubscriptionsIfAny];
}

- (void)removeSubscription:(PKTInternalPushSubscription *)subscription {
  NSParameterAssert(subscription);
  [self.subscriptions removeObject:subscription];
}

- (void)resubscribeToInactiveSubscriptionsIfAny {
  if (self.connected || self.connecting) {
    @synchronized(self) {
      for (PKTInternalPushSubscription *subscription in self.inactiveSubscriptions) {
        subscription.state = PKTPushSubscriptionStateSubscribing;
        [self.client subscribeToChannel:subscription.channel
                             extensions:subscription.extensions
                                 target:subscription
                               selector:@selector(deliverMessage:)];
      }
    }
  } else {
    [self connect];
  }
}

- (void)activateSubscriptionForChannel:(NSString *)channel {
  for (PKTInternalPushSubscription *subscription in self.subscribingSubscriptions) {
    if ([subscription.channel isEqualToString:channel]) {
      subscription.state = PKTPushSubscriptionStateActive;
    }
  }
}

- (void)deactivateSubscriptionForChannel:(NSString *)channel {
  for (PKTInternalPushSubscription *subscription in self.subscribingSubscriptions) {
    if ([subscription.channel isEqualToString:channel]) {
      subscription.state = PKTPushSubscriptionStateInactive;
    }
  }
}

+ (NSDictionary *)extensionsForCredential:(PKTPushCredential *)credential {
  NSParameterAssert(credential);
  
  return @{ @"private_pub_timestamp": credential.timestamp,
            @"private_pub_signature": credential.signature };
}

#pragma mark - Public

- (id)subscribeWithCredential:(PKTPushCredential *)credential eventBlock:(PKTPushEventBlock)block {
  NSDictionary *extensions = [[self class] extensionsForCredential:credential];
  PKTInternalPushSubscription *subscription = [[PKTInternalPushSubscription alloc] initWithChannel:credential.channel
                                                                                        extensions:extensions
                                                                                            client:self
                                                                                        eventBlock:block];
  [self addSubscription:subscription];
  
  return [PKTPushSubscription subscriptionForInternalSubscription:subscription];
}

- (void)unsubscribe:(PKTPushSubscription *)subscription {
  PKTInternalPushSubscription *internalSubscription = subscription.internalSubscription;
  [self removeSubscription:internalSubscription];
  
  [self.client unsubsubscribeFromChannel:internalSubscription.channel target:internalSubscription selector:@selector(deliverMessage:)];
}

#pragma mark - DDCometClientDelegate

- (void)cometClientHandshakeDidSucceed:(DDCometClient *)client {
  [self resubscribeToInactiveSubscriptionsIfAny];
}

- (void)cometClient:(DDCometClient *)client subscriptionDidSucceed:(DDCometSubscription *)subscription {
  [self activateSubscriptionForChannel:subscription.channel];
}

- (void)cometClient:(DDCometClient *)client subscription:(DDCometSubscription *)subscription didFailWithError:(NSError *)error {
  [self deactivateSubscriptionForChannel:subscription.channel];
}

@end
