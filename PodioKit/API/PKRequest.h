//
//  PORequest.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKAPIRequest.h"
#import "PKRequestResult.h"
#import "PKObjectMapper.h"

@class PKObjectMapping, PKRequestOperation;

typedef void (^PKRequestCompletionBlock)(NSError *error, PKRequestResult *result);

@interface PKRequest : NSObject {

@private
  NSString *uri_;
  PKAPIRequestMethod method_;
  NSMutableDictionary *parameters_;
  id body_;
  PKObjectMapping *objectMapping_;
  NSDictionary *userInfo_;
  
  NSPredicate *scopePredicate_;
  NSUInteger offset_;
  
  PKCustomMappingBlock mappingBlock_;
}

@property (copy) NSString *uri;
@property (copy) PKAPIRequestMethod method;
@property (retain) NSMutableDictionary *parameters;
@property (retain) id body;
@property (retain) PKObjectMapping *objectMapping;
@property (retain) NSDictionary *userInfo;
@property (nonatomic, retain) NSPredicate *scopePredicate;
@property NSUInteger offset;
@property (copy) PKCustomMappingBlock mappingBlock;

- (id)initWithURI:(NSString *)uri 
           method:(PKAPIRequestMethod)method;

- (id)initWithURI:(NSString *)uri 
           method:(PKAPIRequestMethod)method 
    objectMapping:(PKObjectMapping *)objectMapping;


+ (PKRequest *)requestWithURI:(NSString *)uri 
                       method:(PKAPIRequestMethod)method;

+ (PKRequest *)requestWithURI:(NSString *)uri 
                       method:(PKAPIRequestMethod)method 
                objectMapping:(PKObjectMapping *)objectMapping;

- (PKRequestOperation *)startWithCompletionBlock:(PKRequestCompletionBlock)completionBlock;

@end
