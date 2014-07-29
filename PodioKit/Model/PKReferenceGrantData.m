//
//  PKReferenceGrantData.m
//  PodioKit
//
//  Created by Romain Briche on 29/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKReferenceGrantData.h"

static NSString * const kPKReferenceGrantDataGrantId = @"GrantId";
static NSString * const kPKReferenceGrantDataGrantedUser = @"GrantedUser";

@interface PKReferenceGrantData ()

@property (nonatomic, assign, readwrite) NSUInteger grantId;
@property (nonatomic, strong, readwrite) PKReferenceProfileData *grantedUser;

@end

@implementation PKReferenceGrantData

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (!self) return nil;

  _grantId = [aDecoder decodeIntForKey:kPKReferenceGrantDataGrantId];
  _grantedUser = [aDecoder decodeObjectForKey:kPKReferenceGrantDataGrantedUser];

  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:_grantId forKey:kPKReferenceGrantDataGrantId];
  [aCoder encodeObject:_grantedUser forKey:kPKReferenceGrantDataGrantedUser];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceGrantData *data = [self data];

  data.grantId = [[dict pk_objectForKey:@"grant_id"] integerValue];
  data.grantedUser = [PKReferenceProfileData dataFromDictionary:[dict pk_objectForKey:@"user"]];

  return data;
}

@end
