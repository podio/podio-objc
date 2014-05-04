//
//  NSURL+PKTParamatersHandling.h
//  PodioKit
//
//  Created by Romain Briche on 22/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (PKTParamatersHandling)

- (NSString *)pkt_valueForQueryParameter:(NSString *)parameter;
- (NSDictionary *)pkt_queryParameters;

@end
