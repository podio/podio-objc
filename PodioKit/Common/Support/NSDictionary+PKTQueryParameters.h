//
//  NSDictionary+PKTQueryParameters.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 09/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (PKTQueryParameters)

- (NSString *)pkt_queryString;
- (NSString *)pkt_escapedQueryString;
- (NSDictionary *)pkt_queryParametersPairs;
- (NSDictionary *)pkt_escapedQueryParametersPairs;

@end
