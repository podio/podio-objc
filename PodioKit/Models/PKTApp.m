//
//  PKTApp.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 03/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTApp.h"
#import "PKTAppAPI.h"
#import "PKTResponse.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTApp

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"appID" : @"app_id",
           @"spaceID" : @"space_id",
           @"iconID" : @"config.icon_id",
           @"name": @"config.name",
           @"itemName": @"config.item_name",
           @"link" : @"link",
  };
}

+ (NSValueTransformer *)linkValueTransformer {
  return [NSValueTransformer pkt_URLTransformer];
}

#pragma mark - API

+ (void)fetchAppWithID:(NSUInteger)appID completion:(void (^)(PKTApp *app, NSError *error))completion {
  PKTRequest *request = [PKTAppAPI requestForAppWithID:appID];
  [[self client] performRequest:request completion:^(PKTResponse *response, NSError *error) {
    PKTApp *app = nil;
    if (!error) {
      app = [[PKTApp alloc] initWithDictionary:response.body];
    }
    
    if (completion) completion(app, error);
  }];
}

@end
