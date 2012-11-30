//
//  PKRequest.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKRequestResult.h"
#import "PKObjectMapper.h"

typedef void (^PKRequestCompletionBlock)(NSError *error, PKRequestResult *result);

typedef NSString * PKRequestMethod;

extern PKRequestMethod const PKRequestMethodGET;
extern PKRequestMethod const PKRequestMethodPOST;
extern PKRequestMethod const PKRequestMethodPUT;
extern PKRequestMethod const PKRequestMethodDELETE;

@class PKObjectMapping, PKRequestOperation;

/** A class describing an API request. A request is used by PKRequestManager to create and enque a new PKRequestOperation instance.
 */
@interface PKRequest : NSObject {

@private
  NSString *uri_;
  PKRequestMethod method_;
  NSMutableDictionary *parameters_;
  id body_;
  PKObjectMapping *objectMapping_;
  NSDictionary *userInfo_;
  
  NSPredicate *scopePredicate_;
  NSUInteger offset_;
  
  PKCustomMappingBlock mappingBlock_;
}

@property (copy) NSString *uri;
@property (copy) PKRequestMethod method;
@property (strong) NSMutableDictionary *parameters;
@property (strong) id body;
@property (strong) PKObjectMapping *objectMapping;
@property (copy) NSArray *objectDataPathComponents;
@property (strong) NSDictionary *userInfo;
@property (strong) NSPredicate *scopePredicate;
@property NSUInteger offset;
@property (copy) PKCustomMappingBlock mappingBlock;

/**
 @param uri The resource URI path.
 @param method The request method.
 @return The request.
 @see initWithURI:method:objectMapping:
 */
- (id)initWithURI:(NSString *)uri method:(PKRequestMethod)method;

/**
 @param uri The resource URI path.
 @param method The request method.
 @param objectMapping The object mapping used to map the result data to the corresponding domain object.
 @return The request.
 */
- (id)initWithURI:(NSString *)uri method:(PKRequestMethod)method objectMapping:(PKObjectMapping *)objectMapping;

/**
 @param uri The resource URI path.
 @param method The request method.
 @return A request.
 @see requestWithURI:method:objectMapping:
 */
+ (PKRequest *)requestWithURI:(NSString *)uri method:(PKRequestMethod)method;

/**
 @param uri The resource URI path.
 @param method The request method.
 @param objectMapping The object mapping used to map the result data to the corresponding domain object.
 @return A request.
 */
+ (PKRequest *)requestWithURI:(NSString *)uri method:(PKRequestMethod)method objectMapping:(PKObjectMapping *)objectMapping;

/**
 @param uri The resource URI path.
 @return A request with the GET method.
 @see requestWithURI:method:
 */
+ (PKRequest *)getRequestWithURI:(NSString *)uri;

/**
 @param uri The resource URI path.
 @return A request with the PUT method.
 @see requestWithURI:method:
 */
+ (PKRequest *)putRequestWithURI:(NSString *)uri;

/**
 @param uri The resource URI path.
 @return A request with the POST method.
 @see requestWithURI:method:
 */
+ (PKRequest *)postRequestWithURI:(NSString *)uri;

/**
 @param uri The resource URI path.
 @return A request with the DELETE method.
 @see requestWithURI:method:
 */
+ (PKRequest *)deleteRequestWithURI:(NSString *)uri;

/** Creates a request operation for this request and adds it to the network queue.
 
 @param completionBlock A block to be executed after the request operation completes and data has been mapped.
 @return The request operation that was added to the network queue. This reference 
 */
- (PKRequestOperation *)startWithCompletionBlock:(PKRequestCompletionBlock)completionBlock;

@end
