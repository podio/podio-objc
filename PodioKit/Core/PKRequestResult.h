//
//  PKRequestResult.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/14/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKRequestResult : NSObject

@property (readonly) NSUInteger responseStatusCode;
@property (readonly) NSString *responseString;
@property (readonly) id responseData; // The raw data
@property (readonly) id parsedData; // The returned data parsed into native containers
@property (readonly) id objectData; // The object(s) returned from the server
@property (readonly) id resultData; // The final mapped object(s)
@property (readonly) NSInteger responseObjectCount;

+ (PKRequestResult *)resultWithResponseStatusCode:(NSUInteger)responseStatusCode responseData:(id)responseData parsedData:(id)parsedData objectData:(id)objectData resultData:(id)resultData;

@end
