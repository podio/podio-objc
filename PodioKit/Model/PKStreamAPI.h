//
//  POStreamAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 8/14/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKBaseAPI.h"

@interface PKStreamAPI : PKBaseAPI

+ (PKRequest *)requestForGlobalStreamWithOffset:(NSUInteger)offset 
                                          limit:(NSUInteger)limit 
                                       dateFrom:(NSDate *)dateFrom 
                                         dateTo:(NSDate *)dateTo;

+ (PKRequest *)requestForSpaceStreamWithId:(NSUInteger)spaceId 
                                    offset:(NSUInteger)offset 
                                     limit:(NSUInteger)limit 
                                  dateFrom:(NSDate *)dateFrom 
                                    dateTo:(NSDate *)dateTo;

+ (PKRequest *)requestForOrganizationStreamWithId:(NSUInteger)organizationId
                                           offset:(NSUInteger)offset 
                                            limit:(NSUInteger)limit 
                                         dateFrom:(NSDate *)dateFrom 
                                           dateTo:(NSDate *)dateTo;

+ (PKRequest *)requestForStreamObjectWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType;

+ (PKRequest *)requestForPostStatusWithText:(NSString *)text 
                                    fileIds:(NSArray *)fileIds 
                                    embedId:(NSUInteger)embedId 
                                embedFileId:(NSUInteger)embedFileId 
                                    spaceId:(NSUInteger)spaceId;

@end
