//
//  NSNumber+PKFormat.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/22/13.
//  Copyright (c) 2013 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (PKFormat)

- (NSString *)pk_numberStringWithUSLocale;
+ (NSNumber *)pk_numberFromStringWithUSLocale:(NSString *)string;

@end
