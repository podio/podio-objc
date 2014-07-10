//
//  PKTResponseSerializer.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 09/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTResponseSerializer.h"
#import "NSString+PKTAdditions.h"

@implementation PKTResponseSerializer

- (id)responseObjectForURLResponse:(NSURLResponse *)response data:(NSData *)data {
  if (![response isKindOfClass:[NSHTTPURLResponse class]]) return nil;
  
  id object = nil;
  NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
  if ([HTTPResponse.allHeaderFields[@"Content-Type"] pkt_containsString:@"application/json"]) {
    object = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
  } else {
    object = data;
  }
  
  return object;
}

@end
