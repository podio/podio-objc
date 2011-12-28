//
//  POStreamActivityCommentData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKReferenceCommentData.h"


static NSString * const PKStreamActivityCommentDataCommentId = @"CommentId";
static NSString * const PKStreamActivityCommentDataValue = @"Value";

@implementation PKReferenceCommentData

@synthesize commentId = commentId_;
@synthesize value = value_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    commentId_ = [aDecoder decodeIntegerForKey:PKStreamActivityCommentDataCommentId];
    value_ = [[aDecoder decodeObjectForKey:PKStreamActivityCommentDataValue] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:commentId_ forKey:PKStreamActivityCommentDataCommentId];
  [aCoder encodeObject:value_ forKey:PKStreamActivityCommentDataValue];
}

- (void)dealloc {
  [value_ release];
  [super dealloc];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceCommentData *data = [self data];
  
  data.commentId = [[dict pk_objectForKey:@"comment_id"] integerValue];
  data.value = [dict pk_objectForKey:@"value"];
  
  return data;
}

@end
