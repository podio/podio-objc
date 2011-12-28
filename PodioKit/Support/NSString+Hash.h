//
//  NSString+Hash.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/3/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Hash)

- (NSString *)pk_MD5String;
- (NSString *)pk_SHA1String;

@end
