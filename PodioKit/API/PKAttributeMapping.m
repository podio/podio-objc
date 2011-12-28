//
//  POAttributeMapping.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/26/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKAttributeMapping.h"

@implementation PKAttributeMapping

@synthesize attributePathComponents = attributePathComponents_;

- (id)initWithAttributePathComponents:(NSArray *)attributePathComponents {
  self = [super init];
  if (self) {
    attributePathComponents_ = [attributePathComponents retain];
  }
  return self;
}

- (id)initWithAttributeName:(NSString *)attributeName {
  NSArray *components = [attributeName componentsSeparatedByString:@"/"];
  return [self initWithAttributePathComponents:components];
}

- (void)dealloc {
  [attributePathComponents_ release];
  [super dealloc];
}

+ (id)mappingForAttributePathComponents:(NSArray *)attributePathComponents {
  return [[[self alloc] initWithAttributePathComponents:attributePathComponents] autorelease];
}

+ (id)mappingForAttributeName:(NSString *)attributeName {
  return [[[self alloc] initWithAttributeName:attributeName] autorelease];
}

- (NSString *)attributePathComponentsString {
  NSLog(@"Key %@", [self.attributePathComponents componentsJoinedByString:@"/"]);
  return [self.attributePathComponents componentsJoinedByString:@"/"];
}

@end
