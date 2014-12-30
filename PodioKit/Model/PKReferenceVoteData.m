//
//  PKReferenceVoteData.m
//  PodioKit
//
//  Created by Lauge Jepsen on 30/12/2014.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKReferenceVoteData.h"

static NSString * const PKReferenceVoteDataVoteId = @"VoteId";
static NSString * const PKReferenceVoteDataType = @"Type";
static NSString * const PKReferenceVoteDataValue = @"Value";

@implementation PKReferenceVoteData

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _voteId = [aDecoder decodeIntegerForKey:PKReferenceVoteDataVoteId];
    _type = [aDecoder decodeIntForKey:PKReferenceVoteDataType];
    _value = [[aDecoder decodeObjectForKey:PKReferenceVoteDataValue] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:_voteId forKey:PKReferenceVoteDataVoteId];
  [aCoder encodeInt:_type forKey:PKReferenceVoteDataType];
  [aCoder encodeObject:_value forKey:PKReferenceVoteDataValue];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceVoteData *data = [self data];
  NSDictionary *voteData = [dict pk_objectForKey:@"voting"];
  data.voteId = [[voteData pk_objectForKey:@"voting_id"] integerValue];
  data.type = [PKConstants voteTypeForString:[voteData pk_objectForKey:@"kind"]];
  
  switch (data.type) {
    case PKVoteTypeAnswer:
      data.value = [[dict pk_objectForKey:@"answer"] pk_objectForKey:@"text"];
      break;
    case PKVoteTypeFivestar:
      data.value = [dict pk_objectForKey:@"rating"];
      break;
    default:
      data.value = nil;
      break;
  }
  
  return data;
}

@end
