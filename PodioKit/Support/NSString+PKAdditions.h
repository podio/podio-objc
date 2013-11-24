//
//  NSString+PKAdditions.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/21/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PKAdditions)

+ (NSString *)pk_generateUUID;

- (NSString *)pk_stringByCapitalizingFirstCharacter;

+ (NSString *)pk_stringByRepeatingString:(NSString *)repeatString times:(NSUInteger)times;

@end
