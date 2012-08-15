//
//  NSString+PKAdditions.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/21/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "NSString+PKAdditions.h"

@implementation NSString (PKAdditions)

+ (NSString *)pk_generateUUID {
  CFUUIDRef theUUID = CFUUIDCreate(NULL);
  CFStringRef string = CFUUIDCreateString(NULL, theUUID);
  CFRelease(theUUID);
  return (__bridge_transfer NSString *)string;
}

- (BOOL)pk_isHTML {
  NSRange range = [self rangeOfString:@"(<\\w+>?).+(</\\w+>)" options:NSRegularExpressionSearch | NSRegularExpressionCaseInsensitive];
  NSRange brRange = [self rangeOfString:@"(<\\w+(\\s+/)?>)" options:NSRegularExpressionSearch | NSRegularExpressionCaseInsensitive];
  BOOL isHTML = range.location != NSNotFound || brRange.location != NSNotFound;
  
  return isHTML;
}

- (NSString *)pk_stringByReplacingNewlinesWithHTMLBreaks {
  return [self stringByReplacingOccurrencesOfString:@"\n" withString:@"<br />"];
}

- (NSString *)pk_stringByCapitalizingFirstCharacter {
  NSString *capitalizedString = nil;
  if ([self length] > 0) {
    NSString *firstChar = [[self substringToIndex:1] capitalizedString];
    capitalizedString = [self stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:firstChar];
  } else {
    capitalizedString = [self copy];
  }
  
  return capitalizedString;
}

+ (NSString *)pk_stringByRepeatingString:(NSString *)repeatString times:(NSUInteger)times {
  NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:times];
  for (NSUInteger i = 0; i < times; ++i) {
    [array addObject:repeatString];
  }
  
  NSString *string = [array componentsJoinedByString:@""];
 
  return string;
}

@end
