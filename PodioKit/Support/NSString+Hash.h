//
//  NSString+Hash.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/3/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hash)

- (NSString *)pk_MD5String;
- (NSString *)pk_SHA1String;

@end
