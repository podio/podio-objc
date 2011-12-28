//
//  PKReferenceMessageData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/7/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKReferenceMessageData.h"


static NSString * const PKStreamItemDataMessageId = @"MessageId";
static NSString * const PKStreamItemDataText = @"Text";
static NSString * const PKStreamItemDataIsReply = @"IsReply";

@implementation PKReferenceMessageData

@synthesize messageId = messageId_;
@synthesize text = text_;
@synthesize isReply = isReply_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    messageId_ = [aDecoder decodeIntegerForKey:PKStreamItemDataMessageId];
    text_ = [[aDecoder decodeObjectForKey:PKStreamItemDataText] copy];
    isReply_ = [aDecoder decodeBoolForKey:PKStreamItemDataIsReply];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:messageId_ forKey:PKStreamItemDataMessageId];
  [aCoder encodeObject:text_ forKey:PKStreamItemDataText];
  [aCoder encodeBool:isReply_ forKey:PKStreamItemDataIsReply];
}

- (void)dealloc {
  [text_ release];
  [super dealloc];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceMessageData *data = [self data];
  
  data.messageId = [[dict pk_objectForKey:@"message_id"] integerValue];
  data.text = [dict pk_objectForKey:@"text"];
  data.isReply = [[dict pk_objectForKey:@"reply"] boolValue];
  
  return data;
}

@end
