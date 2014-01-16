//
//  PKRequestResult.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/14/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKRequestResult : NSObject

@property (readonly) NSUInteger responseStatusCode;
@property (readonly, copy) NSString *responseString;
@property (readonly, strong) id responseData; // The raw data
@property (readonly, strong) id parsedData; // The returned data parsed into native containers
@property (readonly, strong) id objectData; // The parsed object(s) data. Same as parsedData unless the objectDataPathComponents property of PKRequestOperation was used
@property (readonly, strong) id resultData; // The final mapped object(s)
@property (readonly) NSInteger responseObjectCount;

+ (PKRequestResult *)resultWithResponseStatusCode:(NSUInteger)responseStatusCode responseData:(id)responseData parsedData:(id)parsedData objectData:(id)objectData resultData:(id)resultData;

@end
