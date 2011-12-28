//
//  PKRequestResult.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/14/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKRequestResult : NSObject {
  
 @private
  NSUInteger responseStatusCode_;
  NSString *responseString_;
  id responseData_;
  id parsedData_;
  id resultData_;
  NSInteger responseObjectCount_;
}

@property (readonly) NSUInteger responseStatusCode;
@property (readonly) NSString *responseString;
@property (readonly) id responseData;
@property (readonly) id parsedData;
@property (readonly) id resultData;
@property (readonly) NSInteger responseObjectCount;

+ (PKRequestResult *)resultWithResponseStatusCode:(NSUInteger)responseStatusCode responseData:(id)responseData parsedData:(id)parsedData resultData:(id)resultData;

@end
