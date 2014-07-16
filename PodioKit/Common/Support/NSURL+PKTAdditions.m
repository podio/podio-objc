//
//  NSURL+PKTAdditions.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 09/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSURL+PKTAdditions.h"
#import "NSString+PKTAdditions.h"
#import "NSDictionary+PKTQueryParameters.h"

@implementation NSURL (PKTAdditions)

- (NSURL *)pkt_URLByAppendingQueryParameters:(NSDictionary *)parameters {
  if ([parameters count] == 0) return self;
  
  NSMutableString *query = [NSMutableString stringWithString:self.absoluteString];
  
  if (![query pkt_containsString:@"?"]) {
    [query appendString:@"?"];
  } else {
    [query appendString:@"&"];
  }
  
  [query appendString:[parameters pkt_escapedQueryString]];
  
  return [NSURL URLWithString:[query copy]];
}

@end
