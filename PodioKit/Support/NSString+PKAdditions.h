//
//  NSString+POAdditions.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/21/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PKAdditions)

+ (NSString *)pk_generateUUID;

- (BOOL)pk_isHTML;

- (NSString *)pk_stringByReplacingNewlinesWithHTMLBreaks;

- (NSString *)pk_stringByCapitalizingFirstCharacter;

+ (NSString *)pk_stringByRepeatingString:(NSString *)repeatString times:(NSUInteger)times;

@end
