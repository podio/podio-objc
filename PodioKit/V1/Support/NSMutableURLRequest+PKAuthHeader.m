//
//  NSMutableURLRequest+PKAuthHeader.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2013-02-17.
//  Copyright (c) 2013 Citrix Systems, Inc. All rights reserved.
//

#import "NSMutableURLRequest+PKAuthHeader.h"
#import "NSString+PKBase64.h"

@implementation NSMutableURLRequest (PKAuthHeader)

- (void)pk_setBasicAuthHeaderWithUsername:(NSString *)username password:(NSString *)password {
  NSString *credentials = [NSString stringWithFormat:@"%@:%@", username, password];
  NSString *authHeader = [NSString stringWithFormat:@"Basic %@", [credentials pk_base64String]];
  [self setValue:authHeader forHTTPHeaderField:@"Authorization"];
}

@end
