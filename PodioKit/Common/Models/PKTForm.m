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

+ (PKTRequestTaskHandle *)fetchWithID:(NSUInteger)formID completion:(void (^)(PKTForm *form, NSError *error))completion {
  NSParameterAssert(completion);
  
  Class klass = [self class];
  
  PKTRequest *request = [PKTFormsAPI requestForFormWithID:formID];
  PKTRequestTaskHandle *handle = [[PKTClient currentClient] performRequest:request completion:^(PKTResponse *response, NSError *error) {
    PKTForm *form = nil;
    
    if (!form) {
      form = [[klass alloc] initWithDictionary:response.body];
    }
    
    completion(form, error);
  }];

  return handle;
}

@end
