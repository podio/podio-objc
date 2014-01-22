//
//  NSURL+PKTParamatersHandling.m
//  PodioKit
//
//  Created by Romain Briche on 22/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSURL+PKTParamatersHandling.h"
#import "NSString+PKTURL.h"

@implementation NSURL (PKTParamatersHandling)

- (NSString *)pkt_valueForQueryParameter:(NSString *)parameter {
  return [self pkt_queryParameters][parameter];
}

- (NSDictionary *)pkt_queryParameters {
  return [[self query] pkt_URLQueryParameters];
}

@end
