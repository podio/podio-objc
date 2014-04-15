//
//  PKTResponse.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKTResponse : NSObject

@property (nonatomic, copy, readonly) NSData *data; // The raw response body
@property (nonatomic, copy, readonly) NSString *stringData; // NSString representation of the response budy
@property (nonatomic, copy, readonly) id parsedData; // Parsed response body, either NSDictionary or NSArray

- (instancetype)initWithData:(NSData *)data;

@end
