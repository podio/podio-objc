//
//  POStreamStatusData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKStreamStatusData.h"


static NSString * const POStreamStatusDataStatusId = @"StatusId";
static NSString * const POStreamStatusDataValue = @"Value";
static NSString * const POStreamStatusDataRichValue = @"RichValue";
static NSString * const POStreamStatusDataEmbed = @"Embed";
static NSString * const POStreamStatusDataQuestion = @"Question";

@implementation PKStreamStatusData

@synthesize statusId = statusId_;
@synthesize value = value_;
@synthesize richValue = richValue_;
@synthesize embed = embed_;
@synthesize question = question_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    statusId_ = [aDecoder decodeIntegerForKey:POStreamStatusDataStatusId];
    value_ = [[aDecoder decodeObjectForKey:POStreamStatusDataValue] copy];
    richValue_ = [[aDecoder decodeObjectForKey:POStreamStatusDataRichValue] copy];
    embed_ = [aDecoder decodeObjectForKey:POStreamStatusDataEmbed];
    question_ = [aDecoder decodeObjectForKey:POStreamStatusDataQuestion];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:statusId_ forKey:POStreamStatusDataStatusId];
  [aCoder encodeObject:value_ forKey:POStreamStatusDataValue];
  [aCoder encodeObject:richValue_ forKey:POStreamStatusDataRichValue];
  [aCoder encodeObject:embed_ forKey:POStreamStatusDataEmbed];
  [aCoder encodeObject:question_ forKey:POStreamStatusDataQuestion];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKStreamStatusData *data = [self data];
  data.statusId = [[dict pk_objectForKey:@"status_id"] integerValue];
  data.value = [dict pk_objectForKey:@"value"];
  data.richValue = [dict pk_objectForKey:@"rich_value"];
  
  // Embed
  NSDictionary *embedDict = [dict pk_objectForKey:@"embed"];
  if (embedDict != nil) {
    // Pass the current dictionary, since the embed uses both "embed" and "embed_file" keys
    data.embed = [PKEmbedData dataFromDictionary:dict];
  }
  
  // Questions (Only allow one like we do on the website)
  NSArray *questionDicts = [dict pk_objectForKey:@"questions"];
  if (questionDicts != nil && [questionDicts count] > 0) {
    NSDictionary *questionDict = [questionDicts objectAtIndex:0];
    data.question = [PKQuestionData dataFromDictionary:questionDict];
  }
  
  return data;
}

@end
