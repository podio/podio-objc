//
//  PORequestOperation.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/12/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import "PKRequest.h"
#import "PKObjectMapper.h"
#import "PKObjectMapping.h"


extern NSString * const PKNoObjectMapperSetException;

@interface PKRequestOperation : ASIHTTPRequest {

 @private
  PKObjectMapper *objectMapper_;    // Mapper used to perform mapping
  PKRequestCompletionBlock requestCompletionBlock_;
}

@property (strong) PKObjectMapper *objectMapper;
@property (copy) PKRequestCompletionBlock requestCompletionBlock;

+ (PKRequestOperation *)operationWithURLString:(NSString *)urlString 
                                        method:(NSString *)method 
                                          body:(id)body;

@end
