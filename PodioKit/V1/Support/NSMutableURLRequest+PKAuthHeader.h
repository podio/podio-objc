//
//  NSMutableURLRequest+PKAuthHeader.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2013-02-17.
//  Copyright (c) 2013 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableURLRequest (PKAuthHeader)

- (void)pk_setBasicAuthHeaderWithUsername:(NSString *)username password:(NSString *)password;

@end
