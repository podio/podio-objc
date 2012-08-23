//
//  PKStreamAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 8/14/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKStreamAPI.h"
#import "NSDate+PKAdditions.h"

@implementation PKStreamAPI

+ (PKRequest *)requestForGlobalStreamWithOffset:(NSUInteger)offset 
                                          limit:(NSUInteger)limit 
                                       dateFrom:(NSDate *)dateFrom 
                                         dateTo:(NSDate *)dateTo {
  PKRequest *request = [PKRequest requestWithURI:@"/stream/v2/" method:PKAPIRequestMethodGET];
  request.offset = offset;
  
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [NSString stringWithFormat:@"%d", offset], @"offset",
                                     [NSString stringWithFormat:@"%d", limit], @"limit", nil];
  
  if (dateFrom != nil) {
    [parameters setObject:[[dateFrom pk_UTCDateFromLocalDate] pk_dateTimeString] forKey:@"date_from"];
  }
  
  if (dateTo != nil) {
    [parameters setObject:[[dateTo pk_UTCDateFromLocalDate] pk_dateTimeString] forKey:@"date_to"];
  }
  
  request.parameters = parameters;
  
  return request;
}

+ (PKRequest *)requestForSpaceStreamWithId:(NSUInteger)spaceId 
                                    offset:(NSUInteger)offset 
                                     limit:(NSUInteger)limit 
                                  dateFrom:(NSDate *)dateFrom 
                                    dateTo:(NSDate *)dateTo {  
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/stream/space/%d/v2/", spaceId] method:PKAPIRequestMethodGET];
  request.offset = offset;
  
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [NSString stringWithFormat:@"%d", offset], @"offset",
                                     [NSString stringWithFormat:@"%d", limit], @"limit", nil];
  
  if (dateFrom != nil) {
    [parameters setObject:[[dateFrom pk_UTCDateFromLocalDate] pk_dateTimeString] forKey:@"date_from"];
  }
  
  if (dateTo != nil) {
    [parameters setObject:[[dateTo pk_UTCDateFromLocalDate] pk_dateTimeString] forKey:@"date_to"];
  }
  
  request.parameters = parameters;
  
  return request;
}

+ (PKRequest *)requestForOrganizationStreamWithId:(NSUInteger)organizationId
                                           offset:(NSUInteger)offset 
                                            limit:(NSUInteger)limit 
                                         dateFrom:(NSDate *)dateFrom 
                                           dateTo:(NSDate *)dateTo {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/stream/org/%d/v2/", organizationId] method:PKAPIRequestMethodGET];
  request.offset = offset;
  
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [NSString stringWithFormat:@"%d", offset], @"offset",
                                     [NSString stringWithFormat:@"%d", limit], @"limit", nil];
  
  if (dateFrom != nil) {
    [parameters setObject:[[dateFrom pk_UTCDateFromLocalDate] pk_dateTimeString] forKey:@"date_from"];
  }
  
  if (dateTo != nil) {
    [parameters setObject:[[dateTo pk_UTCDateFromLocalDate] pk_dateTimeString] forKey:@"date_to"];
  }
  
  request.parameters = parameters;
  
  return request;
}

+ (PKRequest *)requestForStreamObjectWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType {
  NSString * uri = [NSString stringWithFormat:@"/stream/%@/%d/v2", [PKConstants stringForReferenceType:referenceType], referenceId];
  return [PKRequest requestWithURI:uri method:PKAPIRequestMethodGET];
}

+ (PKRequest *)requestForPostStatusWithText:(NSString *)text 
                                    fileIds:(NSArray *)fileIds 
                                    embedId:(NSUInteger)embedId 
                                embedFileId:(NSUInteger)embedFileId 
                                    spaceId:(NSUInteger)spaceId {
  PKRequest *request = [PKRequest requestWithURI:@"/status/" 
                                          method:PKAPIRequestMethodPOST 
                                   objectMapping:nil];
  
  NSMutableDictionary * body = [NSMutableDictionary dictionaryWithObjectsAndKeys:@(spaceId), @"space_id", text, @"value", nil];
  
	if ([fileIds count] > 0) {
    [body setObject:fileIds forKey:@"file_ids"];
	}
  
  if (embedId > 0) {
    [body setObject:@(embedId) forKey:@"embed_id"];
  }
  
  if (embedFileId > 0) {
    [body setObject:@(embedFileId) forKey:@"embed_file_id"];
  }
  
  request.body = body;
  
  return request;
}

@end
