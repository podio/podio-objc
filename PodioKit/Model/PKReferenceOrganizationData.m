//
//  PKReferenceOrganizationData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/12/13.
//  Copyright (c) 2013 Citrix Systems, Inc. All rights reserved.
//

#import "PKReferenceOrganizationData.h"

static NSString * const PKReferenceOrganizationDataOrgId = @"OrgId";
static NSString * const PKReferenceOrganizationDataName = @"Name";

@interface PKReferenceOrganizationData ()

@property (nonatomic) NSUInteger organizationId;
@property (nonatomic, copy) NSString *name;

@end

@implementation PKReferenceOrganizationData

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _organizationId = [aDecoder decodeIntForKey:PKReferenceOrganizationDataOrgId];
    _name = [[aDecoder decodeObjectForKey:PKReferenceOrganizationDataName] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:_organizationId forKey:PKReferenceOrganizationDataOrgId];
  [aCoder encodeObject:_name forKey:PKReferenceOrganizationDataName];
}

#pragma mark - PKObjectData

+ (instancetype)dataFromDictionary:(NSDictionary *)dict {
  if (!dict) return nil;
  
  PKReferenceOrganizationData *data = [self data];
  data.organizationId = [[dict pk_objectForKey:@"org_id"] unsignedIntegerValue];
  data.name = [dict pk_objectForKey:@"name"];
  
  return data;
}

@end
