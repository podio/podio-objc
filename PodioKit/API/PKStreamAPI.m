//
//  PKStreamAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 8/14/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKStreamAPI.h"
#import "NSDate+PKFormatting.h"

@implementation PKStreamAPI

+ (PKRequest *)requestForGlobalStreamWithOffset:(NSUInteger)offset 
                                          limit:(NSUInteger)limit 
                                       dateFrom:(NSDate *)dateFrom 
                                         dateTo:(NSDate *)dateTo {
  PKRequest *request = [PKRequest requestWithURI:@"/stream/v2/" method:PKRequestMethodGET];
  request.offset = offset;
  
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [NSString stringWithFormat:@"%ld", (unsigned long)offset], @"offset",
                                     [NSString stringWithFormat:@"%ld", (unsigned long)limit], @"limit", nil];
  
  if (dateFrom != nil) {
    [parameters setObject:[dateFrom pk_UTCDateTimeString] forKey:@"date_from"];
  }
  
  if (dateTo != nil) {
    [parameters setObject:[dateTo pk_UTCDateTimeString] forKey:@"date_to"];
  }
  
  request.parameters = parameters;
  
  return request;
}

+ (PKRequest *)requestForSpaceStreamWithId:(NSUInteger)spaceId 
                                    offset:(NSUInteger)offset 
                                     limit:(NSUInteger)limit 
                                  dateFrom:(NSDate *)dateFrom 
                                    dateTo:(NSDate *)dateTo {  
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/stream/space/%ld/v2/", (unsigned long)spaceId] method:PKRequestMethodGET];
  request.offset = offset;
  
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [NSString stringWithFormat:@"%ld", (unsigned long)offset], @"offset",
                                     [NSString stringWithFormat:@"%ld", (unsigned long)limit], @"limit", nil];
  
  if (dateFrom != nil) {
    [parameters setObject:[dateFrom pk_UTCDateTimeString] forKey:@"date_from"];
  }
  
  if (dateTo != nil) {
    [parameters setObject:[dateTo pk_UTCDateTimeString] forKey:@"date_to"];
  }
  
  request.parameters = parameters;
  
  return request;
}

+ (PKRequest *)requestForOrganizationStreamWithId:(NSUInteger)organizationId
                                           offset:(NSUInteger)offset 
                                            limit:(NSUInteger)limit 
                                         dateFrom:(NSDate *)dateFrom 
                                           dateTo:(NSDate *)dateTo {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/stream/org/%ld/v2/", (unsigned long)organizationId] method:PKRequestMethodGET];
  request.offset = offset;
  
  NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     [NSString stringWithFormat:@"%ld", (unsigned long)offset], @"offset",
                                     [NSString stringWithFormat:@"%ld", (unsigned long)limit], @"limit", nil];
  
  if (dateFrom != nil) {
    [parameters setObject:[dateFrom pk_UTCDateTimeString] forKey:@"date_from"];
  }
  
  if (dateTo != nil) {
    [parameters setObject:[dateTo pk_UTCDateTimeString] forKey:@"date_to"];
  }
  
  request.parameters = parameters;
  
  return request;
}

+ (PKRequest *)requestForStreamObjectWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType {
  NSString * uri = [NSString stringWithFormat:@"/stream/%@/%ld/v2", [PKConstants stringForReferenceType:referenceType], (unsigned long)referenceId];
  return [PKRequest requestWithURI:uri method:PKRequestMethodGET];
}

+ (PKRequest *)requestForPostStatusWithText:(NSString *)text 
                                    fileIds:(NSArray *)fileIds 
                                    embedId:(NSUInteger)embedId 
                                embedFileId:(NSUInteger)embedFileId 
                                    spaceId:(NSUInteger)spaceId
                                alertInvite:(BOOL)alertInvite {
  PKRequest *request = [PKRequest requestWithURI:@"/status/" 
                                          method:PKRequestMethodPOST 
                                   objectMapping:nil];
  
  request.parameters[@"alert_invite"] = @(alertInvite);
  
  NSMutableDictionary *body = [NSMutableDictionary dictionaryWithObjectsAndKeys:@(spaceId), @"space_id", text, @"value", nil];
  
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

+ (PKRequest *)requestToUpdateStatusWithId:(NSUInteger)statusId
                                      text:(NSString *)text
                                   fileIds:(NSArray *)fileIds
                                   embedId:(NSUInteger)embedId
                                  embedURL:(NSURL *)embedURL {
  NSString *uri = [NSString stringWithFormat:@"/status/%ld", (unsigned long)statusId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodPUT];
  
  NSMutableDictionary *body = [NSMutableDictionary new];
  body[@"value"] = text;
  
  if ([fileIds count] > 0) {
    body[@"file_ids"] = fileIds;
  }
  
  if (embedId > 0) {
    body[@"embed_id"] = @(embedId);
  }
  
  if (embedURL) {
    body[@"embed_url"] = embedURL.absoluteString;
  }
  
  request.body = [body copy];
  
  return request;
}

@end
