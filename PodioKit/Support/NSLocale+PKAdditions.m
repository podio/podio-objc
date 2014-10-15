//
//  NSLocale+PKAdditions.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 15/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSLocale+PKAdditions.h"

@implementation NSLocale (PKAdditions)

- (NSString *)pk_localeIdentifierWithLanguageAndRegion {
  NSString *identifier = nil;
  
  NSString *localeIdentifier = [self localeIdentifier];
  NSDictionary *localeComponents = [NSLocale componentsFromLocaleIdentifier:localeIdentifier];
  
  // Only use language and country
  NSString *languageCode = localeComponents[NSLocaleLanguageCode];
  NSString *countryCode = localeComponents[NSLocaleCountryCode];
  if (languageCode && countryCode) {
    identifier = [NSLocale localeIdentifierFromComponents:@{ NSLocaleLanguageCode: languageCode, NSLocaleCountryCode: countryCode}];
  }
  
  return identifier;
}

- (NSString *)pk_localeIdentifierWithLanguageAndRegionWithFallback:(NSString *)fallbackIdentifier {
  return [self pk_localeIdentifierWithLanguageAndRegion] ?: fallbackIdentifier;
}

@end
