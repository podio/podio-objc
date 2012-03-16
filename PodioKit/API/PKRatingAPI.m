//
//  PKRatingAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKRatingAPI.h"

@implementation PKRatingAPI

+ (PKRequest *)requestForLikeWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType {
	NSString * uri = [NSString stringWithFormat:@"/rating/%@/%d/like", [PKConstants stringForReferenceType:referenceType], referenceId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKAPIRequestMethodPOST objectMapping:nil];
	request.body = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt:1] forKey:@"value"];
  
  return request;
}

+ (PKRequest *)requestForUnlikeWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType {
	NSString *uri = [NSString stringWithFormat:@"/rating/%@/%d/like", [PKConstants stringForReferenceType:referenceType], referenceId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKAPIRequestMethodDELETE objectMapping:nil];
  
  return request;
}

@end
