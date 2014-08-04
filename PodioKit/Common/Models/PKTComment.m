//
//  PKTComment.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTComment.h"
#import "PKTEmbed.h"
#import "PKTFile.h"
#import "PKTCommentsAPI.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTComment

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"commentID": @"comment_id",
    @"referenceType": @"ref.type",
    @"referenceID": @"ref.id",
    @"value": @"value",
    @"richValue": @"rich_value",
    @"createdOn": @"created_on",
    @"embed": @"embed",
    @"embedFile": @"embed_file",
    @"files": @"files"
  };
}

+ (NSValueTransformer *)referenceTypeValueTransformer {
  return [NSValueTransformer pkt_referenceTypeTransformer];
}

+ (NSValueTransformer *)createdOnValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)embedValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTEmbed class]];
}

+ (NSValueTransformer *)embedFileValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTFile class]];
}

+ (NSValueTransformer *)filesValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTFile class]];
}

#pragma mark - API

+ (PKTAsyncTask *)addCommentForObjectWithText:(NSString *)text referenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType {
  return [self addCommentForObjectWithText:text referenceID:referenceID referenceType:referenceType files:nil];
}

+ (PKTAsyncTask *)addCommentForObjectWithText:(NSString *)text referenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType files:(NSArray *)files {
  return [self addCommentForObjectWithText:text referenceID:referenceID referenceType:referenceType files:files embedID:0];
}

+ (PKTAsyncTask *)addCommentForObjectWithText:(NSString *)text referenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType files:(NSArray *)files embedID:(NSUInteger)embedID {
  return [self addCommentForObjectWithText:text referenceID:referenceID referenceType:referenceType files:files embedID:embedID embedURL:nil];
}

+ (PKTAsyncTask *)addCommentForObjectWithText:(NSString *)text referenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType files:(NSArray *)files embedURL:(NSURL *)embedURL {
  return [self addCommentForObjectWithText:text referenceID:referenceID referenceType:referenceType files:files embedID:0 embedURL:embedURL];
}

+ (PKTAsyncTask *)addCommentForObjectWithText:(NSString *)text referenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType files:(NSArray *)files embedID:(NSUInteger)embedID embedURL:(NSURL *)embedURL {
  NSArray *fileIDs = [files valueForKey:@"fileID"];
  
  PKTRequest *request = [PKTCommentsAPI requestToAddCommentToObjectWithReferenceID:referenceID
                                                                    referenceType:referenceType
                                                                            value:text
                                                                            files:fileIDs
                                                                          embedID:embedID
                                                                         embedURL:embedURL];
  
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  PKTAsyncTask *task = [requestTask map:^id(PKTResponse *response) {
    return [[self alloc] initWithDictionary:response.body];
  }];

  return task;
}

@end
