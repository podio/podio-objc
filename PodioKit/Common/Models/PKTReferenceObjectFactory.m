//
//  PKTReferenceObjectFactory.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 30/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTReferenceObjectFactory.h"
#import "PKTOrganization.h"
#import "PKTWorkspace.h"
#import "PKTProfile.h"
#import "PKTTask.h"
#import "PKTItem.h"
#import "PKTApp.h"
#import "PKTComment.h"
#import "PKTStatus.h"
#import "PKTConstants.h"
#import "NSValueTransformer+PKTConstants.h"

@implementation PKTReferenceObjectFactory

#pragma mark - Public

+ (id)referenceObjectFromDictionary:(NSDictionary *)dictionary {
  PKTReferenceType refType = [NSValueTransformer pkt_referenceTypeFromString:dictionary[@"type"]];
  NSDictionary *data = dictionary[@"data"];
  
  return [self referenceObjectFromData:data type:refType];
}

+ (id)referenceObjectFromData:(NSDictionary *)data type:(NSUInteger)referenceType {
  id obj = nil;
  
  Class klass = [self classForReferenceType:referenceType];
  if (data && klass && [klass instancesRespondToSelector:@selector(initWithDictionary:)]) {
    obj = [[klass alloc] initWithDictionary:data];
  }
  
  return obj;
}

#pragma mark - Private

+ (Class)classForReferenceType:(PKTReferenceType)referenceType {
  Class klass = nil;
  
  switch (referenceType) {
    case PKTReferenceTypeOrg:
      return [PKTOrganization class];
      break;
    case PKTReferenceTypeSpace:
      return [PKTWorkspace class];
      break;
    case PKTReferenceTypeProfile:
      return [PKTProfile class];
      break;
    case PKTReferenceTypeTask:
      return [PKTTask class];
      break;
    case PKTReferenceTypeItem:
      return [PKTItem class];
      break;
    case PKTReferenceTypeApp:
      return [PKTApp class];
      break;
    case PKTReferenceTypeComment:
      return [PKTComment class];
      break;
    case PKTReferenceTypeStatus:
      return [PKTStatus class];
      break;
    default:
      break;
  }
  
  return klass;
}

@end
