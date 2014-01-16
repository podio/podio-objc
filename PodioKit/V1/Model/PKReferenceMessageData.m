//
//  PKReferenceMessageData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/7/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKReferenceMessageData.h"


static NSString * const PKStreamItemDataMessageId = @"MessageId";
static NSString * const PKStreamItemDataText = @"Text";
static NSString * const PKStreamItemDataIsReply = @"IsReply";
static NSString * const PKStreamItemDataFiles = @"Files";
static NSString * const PKStreamItemDataEmbed = @"Embed";

@implementation PKReferenceMessageData

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _messageId = [aDecoder decodeIntegerForKey:PKStreamItemDataMessageId];
    _text = [[aDecoder decodeObjectForKey:PKStreamItemDataText] copy];
    _isReply = [aDecoder decodeBoolForKey:PKStreamItemDataIsReply];
    _files = [[aDecoder decodeObjectForKey:PKStreamItemDataFiles] copy];
    _embed = [aDecoder decodeObjectForKey:PKStreamItemDataEmbed];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:_messageId forKey:PKStreamItemDataMessageId];
  [aCoder encodeObject:_text forKey:PKStreamItemDataText];
  [aCoder encodeBool:_isReply forKey:PKStreamItemDataIsReply];
  [aCoder encodeObject:_files forKey:PKStreamItemDataFiles];
  [aCoder encodeObject:_embed forKey:PKStreamItemDataEmbed];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceMessageData *data = [self data];
  
  data.messageId = [[dict pk_objectForKey:@"message_id"] integerValue];
  data.text = [dict pk_objectForKey:@"text"];
  data.isReply = [[dict pk_objectForKey:@"reply"] boolValue];
  data.files = [PKFileData dataObjectsFromArray:[dict pk_objectForKey:@"files"]];
  data.embed = [PKEmbedData dataFromDictionary:dict];
  
  return data;
}

@end
