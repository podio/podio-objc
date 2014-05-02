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
#import "PKTCommentAPI.h"
#import "PKTResponse.h"
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

+ (void)addCommentForObjectWithText:(NSString *)text referenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType completion:(void (^)(PKTComment *comment, NSError *error))completion {
  [self addCommentForObjectWithText:text referenceID:referenceID referenceType:referenceType files:nil completion:completion];
}

+ (void)addCommentForObjectWithText:(NSString *)text referenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType files:(NSArray *)files completion:(void (^)(PKTComment *comment, NSError *error))completion {
  [self addCommentForObjectWithText:text referenceID:referenceID referenceType:referenceType files:files embedID:0 completion:completion];
}

+ (void)addCommentForObjectWithText:(NSString *)text referenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType files:(NSArray *)files embedID:(NSUInteger)embedID completion:(void (^)(PKTComment *comment, NSError *error))completion {
  [self addCommentForObjectWithText:text referenceID:referenceID referenceType:referenceType files:files embedID:embedID embedURL:nil completion:completion];
}

+ (void)addCommentForObjectWithText:(NSString *)text referenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType files:(NSArray *)files embedURL:(NSURL *)embedURL completion:(void (^)(PKTComment *comment, NSError *error))completion {
  [self addCommentForObjectWithText:text referenceID:referenceID referenceType:referenceType files:files embedID:0 embedURL:embedURL completion:completion];
}

+ (void)addCommentForObjectWithText:(NSString *)text referenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType files:(NSArray *)files embedID:(NSUInteger)embedID embedURL:(NSURL *)embedURL completion:(void (^)(PKTComment *comment, NSError *error))completion {
  NSArray *fileIDs = [files valueForKey:@"fileID"];
  
  PKTRequest *request = [PKTCommentAPI requestToAddCommentToObjectWithReferenceID:referenceID
                                                                    referenceType:referenceType
                                                                            value:text
                                                                            files:fileIDs
                                                                          embedID:embedID
                                                                         embedURL:embedURL];
  [[self client] performRequest:request completion:^(PKTResponse *response, NSError *error) {
    PKTComment *comment = nil;
    
    if (!error) {
      comment = [[PKTComment alloc] initWithDictionary:response.body];
    }
    
    if (comment) completion(comment, error);
  }];
}

@end
