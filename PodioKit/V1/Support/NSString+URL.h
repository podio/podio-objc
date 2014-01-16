//
//  NSString+URL.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/14/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)

- (NSString *)pk_escapedURLString;

- (NSString *)pk_unescapedURLString;

@end
