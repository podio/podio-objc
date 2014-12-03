//
//  PKTReference.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 30/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTReference.h"
#import "PKTClient.h"
#import "PKTReferenceGroup.h"
#import "PKTReferenceObjectFactory.h"
#import "NSValueTransformer+PKTTransformers.h"
#import "NSArray+PKTAdditions.h"

@implementation PKTReference

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"referenceID" : @"id",
           @"referenceType" : @"type",
           @"referenceObject" : @"data",
           };
}

+ (NSValueTransformer *)referenceTypeValueTransformer {
  return [NSValueTransformer pkt_referenceTypeTransformer];
}

+ (NSValueTransformer *)referenceObjectValueTransformer {
  return [NSValueTransformer pkt_transformerWithBlock:^id(NSDictionary *refDict) {
    return [PKTReferenceObjectFactory referenceObjectFromDictionary:refDict];
  }];
}

#pragma mark - Public

+ (PKTAsyncTask *)searchForReferenceWithText:(NSString *)text target:(PKTReferenceTarget)target targetParameters:(NSDictionary *)targetParamers limit:(NSUInteger)limit {
  PKTRequest *request = [PKTReferenceAPI requestToSearchForReferenceWithText:text
                                                                      target:target
                                                            targetParameters:targetParamers
                                                                       limit:limit];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  return [task map:^id(PKTResponse *response) {
    return [response.body pkt_mappedArrayWithBlock:^id(NSDictionary *dict) {
      return [[PKTReferenceGroup alloc] initWithDictionary:dict];
    }];
  }];
}

@end
