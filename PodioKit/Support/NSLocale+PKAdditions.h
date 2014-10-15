//
//  NSLocale+PKAdditions.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 15/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSLocale (PKAdditions)

- (NSString *)pk_localeIdentifierWithLanguageAndRegion;
- (NSString *)pk_localeIdentifierWithLanguageAndRegionWithFallback:(NSString *)fallbackIdentifier;

@end
