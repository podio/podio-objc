//
//  PKTMessage.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 13/11/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTMessage.h"

@implementation PKTMessage

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"messageID": @"message_id"
           };
}

@end
