//
//  PKTForm.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTForm.h"
#import "PKTFormField.h"
#import "PKTFormSettings.h"
#import "PKTFormsAPI.h"
#import "PKTClient.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTForm

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"formID" : @"form_id",
           @"spaceID" : @"space_id",
           @"appID" : @"app_id",
           @"hasItemCapacity" : @"item_capacity",
           @"allowsAttachments" : @"attachments",
           };
}

+ (NSValueTransformer *)statusValueTransformer {
  return [NSValueTransformer pkt_transformerWithDictionary:@{
                                                             @"active" : @(PKTFormStatusActive),
                                                             @"disabled" : @(PKTFormStatusDisabled),
                                                             @"deleted" : @(PKTFormStatusDeleted),
                                                             }];
}

+ (NSValueTransformer *)fieldsValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTFormField class]];
}

+ (NSValueTransformer *)settingsValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTFormSettings class]];
}

#pragma mark - Public

+ (PKTAsyncTask *)fetchWithID:(NSUInteger)formID {
  PKTRequest *request = [PKTFormsAPI requestForFormWithID:formID];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  PKTAsyncTask *task = [requestTask map:^id(PKTResponse *response) {
    return [[self alloc] initWithDictionary:response.body];
  }];

  return task;
}

@end
