//
//  POAPIResponse.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-01.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PKAPIResponse : NSObject {

 @protected
  NSData *responseData_;
  NSError *error_;
}

@property (nonatomic, readonly) NSData *responseData;
@property (nonatomic, readonly) NSString *responseString;
@property (nonatomic, readonly) id responseObjectFromJSON;
@property (nonatomic, strong) NSError *error;

- (id)initWithData:(NSData *)data;

+ (id)responseWithData:(NSData *)data;

@end
