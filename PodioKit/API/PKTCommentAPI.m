//
//  PKTCommentAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTCommentAPI.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTCommentAPI

+ (PKTRequest *)requestToAddCommentToObjectWithReferenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType value:(NSString *)value files:(NSArray *)files embedID:(NSUInteger)embedID embedURL:(NSURL *)embedURL {
  NSParameterAssert(referenceID > 0);
  NSParameterAssert(referenceType != PKTReferenceTypeNone);
  NSParameterAssert(value);
  
  NSString *refTypeString = [[NSValueTransformer pkt_referenceTypeTransformer] reverseTransformedValue:@(referenceType)];
  NSString *path = PKTRequestPath(@"/comment/%@/%lu/", refTypeString, (unsigned long)referenceID);
  
  NSMutableDictionary *parameters = [NSMutableDictionary new];
  parameters[@"value"] = value;
  
  if ([files count] > 0) {
    parameters[@"file_ids"] = files;
  }
  
  if (embedID > 0) {
    parameters[@"embed_id"] = @(embedID);
  }
  
  if (embedURL) {
    parameters[@"embed_url"] = [embedURL absoluteString];
  }
  
  PKTRequest *request = [PKTRequest POSTRequestWithPath:path parameters:parameters];
  
  return request;
}

@end
