//
//  POTransformableAnswerData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 8/23/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKItemFieldValueOptionData.h"


static NSString * const POTransformableAnswerDataAnswerIdKey = @"AnswerId";
static NSString * const POTransformableAnswerDataAnswerKey = @"Answer";
static NSString * const POTransformableAnswerDataSelectedKey = @"Selected";

@implementation PKItemFieldValueOptionData

@synthesize optionId = optionId_;
@synthesize text = text_;
@synthesize selected = selected_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    optionId_ = [aDecoder decodeIntegerForKey:POTransformableAnswerDataAnswerIdKey];
    text_ = [[aDecoder decodeObjectForKey:POTransformableAnswerDataAnswerKey] copy];
    selected_ = [aDecoder decodeBoolForKey:POTransformableAnswerDataSelectedKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:optionId_ forKey:POTransformableAnswerDataAnswerIdKey];
  [aCoder encodeObject:text_ forKey:POTransformableAnswerDataAnswerKey];
  [aCoder encodeBool:selected_ forKey:POTransformableAnswerDataSelectedKey];
}


- (BOOL)isEqual:(id)object {
  BOOL equal = NO;
  if (![object isKindOfClass:[self class]]) {
    return equal;
  }
  
  if (self.optionId < 0) {
    // Compare strings
    equal = [self.text isEqualToString:[object text]];
  } else {
    // Compare ids
    equal = self.optionId == [object optionId];
  }
  
  return equal;
}

- (NSUInteger)hash {
  return [[NSNumber numberWithInteger:self.optionId] hash];
}


- (NSString *)description {
  // Print as dictionary
  return [[NSDictionary dictionaryWithObjectsAndKeys:
           [NSNumber numberWithInteger:optionId_], @"optionId", 
           text_, @"text", 
           [NSNumber numberWithBool:selected_], @"selected", nil] description];
}

@end
