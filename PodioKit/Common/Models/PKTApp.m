//
//  PKTApp.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 03/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTApp.h"
#import "PKTAppField.h"
#import "PKTAppsAPI.h"
#import "PKTClient.h"
#import "NSValueTransformer+PKTTransformers.h"
#import "NSArray+PKTAdditions.h"

@implementation PKTApp

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"appID" : @"app_id",
           @"spaceID" : @"space_id",
           @"iconID" : @"config.icon_id",
           @"name": @"config.name",
           @"itemName": @"config.item_name",
           @"appDescription": @"config.description",
           @"link" : @"link",
           @"fields" : @"fields"
  };
}

+ (NSValueTransformer *)linkValueTransformer {
  return [NSValueTransformer pkt_URLTransformer];
}

+ (NSValueTransformer *)fieldsValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTAppField class]];
}

#pragma mark - API

+ (PKTAsyncTask *)fetchAppWithID:(NSUInteger)appID {
  PKTRequest *request = [PKTAppsAPI requestForAppWithID:appID];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  Class objectClass = [self class];
  
  PKTAsyncTask *task = [requestTask map:^id(PKTResponse *response) {
    return [[objectClass alloc] initWithDictionary:response.body];
  }];
  
  return task;
}

+ (PKTAsyncTask *)fetchAppsInWorkspaceWithID:(NSUInteger)spaceID {
  PKTRequest *request = [PKTAppsAPI requestForAppsInWorkspaceWithID:spaceID];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  Class objectClass = [self class];
  
  PKTAsyncTask *task = [requestTask map:^id(PKTResponse *response) {
    return [response.body pkt_mappedArrayWithBlock:^id(NSDictionary *dict) {
      return [[objectClass alloc] initWithDictionary:dict];
    }];
  }];
  
  return task;
}

#pragma mark - Public

- (PKTAppField *)fieldWithExternalID:(NSString *)externalID {
  __block PKTAppField *field = nil;
  
  [self.fields enumerateObjectsUsingBlock:^(PKTAppField *currentField, NSUInteger idx, BOOL *stop) {
    if ([currentField.externalID isEqualToString:externalID]) {
      field = currentField;
      *stop = YES;
    }
  }];
  
  return field;
}

@end
