//
//  PKReferenceAlertData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/7/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKReferenceAlertData.h"


static NSString * const PKReferenceAlertDataText = @"Text";

@implementation PKReferenceAlertData

@synthesize text = text_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    text_ = [[aDecoder decodeObjectForKey:PKReferenceAlertDataText] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:text_ forKey:PKReferenceAlertDataText];
}

- (void)dealloc {
  [text_ release];
  [super dealloc];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceAlertData *data = [self data];
  
  data.text = [dict pk_objectForKey:@"text"];
  
  return data;
}

@end
