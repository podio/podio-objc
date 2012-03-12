//
//  PodioKit.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/27/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - General

#import "PKConstants.h"
#import "PKLog.h"
#import "PKAssert.h"

#pragma mark - Client

#import "PKOAuth2Client.h"
#import "PKOAuth2Token.h"
#import "PKAPIClient.h"
#import "PKAPIRequest.h"
#import "PKAPIResponse.h"
#import "PKRequestOperation.h"
#import "PKFileOperation.h"
#import "PKRequest.h"
#import "PKRequestManager.h"
#import "PKRequestResult.h"

#pragma mark - APIs

#import "PKBaseAPI.h"
#import "PKCommentAPI.h"
#import "PKConversationAPI.h"
#import "PKFileAPI.h"
#import "PKItemAPI.h"
#import "PKNotificationAPI.h"
#import "PKOrganizationAPI.h"
#import "PKQuestionAPI.h"
#import "PKRatingAPI.h"
#import "PKSpaceAPI.h"
#import "PKStreamAPI.h"
#import "PKTaskAPI.h"
#import "PKLinkedAccountAPI.h"
#import "PKSearchAPI.h"
#import "PKContactAPI.h"

#pragma mark - Mapping

#import "PKObjectMapper.h"
#import "PKObjectRepository.h"
#import "PKObjectMapping.h"
#import "PKAttributeMapping.h"
#import "PKPropertyMapping.h"
#import "PKValueMapping.h"
#import "PKCompoundMapping.h"
#import "PKRelationshipMapping.h"
#import "PKStandaloneMapping.h"
#import "PKMappableObject.h"
#import "PKMappingManager.h"
#import "PKMappingProvider.h"
#import "PKDefaultMappingProvider.h"
#import "PKCoreDataMappingManager.h"
#import "PKCoreDataRepository.h"
#import "PKDefaultObjectRepository.h"

#pragma mark - Storage

#import "PKBaseObject.h"
#import "PKManagedObject.h"

#pragma mark - Data

#import "PKObjectData.h"
#import "PKItemFieldValueDataFactory.h"
#import "PKItemFieldValueCalculationData.h"
#import "PKItemFieldValueContactData.h"
#import "PKItemFieldValueDateData.h"
#import "PKItemFieldValueEmbedData.h"
#import "PKItemFieldValueItemData.h"
#import "PKItemFieldValueMediaData.h"
#import "PKItemFieldValueMoneyData.h"
#import "PKItemFieldValueOptionData.h"
#import "PKAppFieldContactData.h"
#import "PKAppFieldMoneyData.h"
#import "PKAppFieldOptionsData.h"
#import "PKReferenceDataFactory.h"
#import "PKReferenceAlertData.h"
#import "PKReferenceAppData.h"
#import "PKReferenceCommentData.h"
#import "PKReferenceItemData.h"
#import "PKReferenceMeetingData.h"
#import "PKReferenceMessageData.h"
#import "PKReferenceProfileData.h"
#import "PKReferenceRatingData.h"
#import "PKReferenceSpaceData.h"
#import "PKReferenceStatusData.h"
#import "PKReferenceTaskActionData.h"
#import "PKSpaceCreateData.h"
#import "PKStreamActionData.h"
#import "PKStreamActivityAnswerData.h"
#import "PKStreamActivityDataFactory.h"
#import "PKStreamActivityTaskData.h"
#import "PKStreamDataFactory.h"
#import "PKStreamItemData.h"
#import "PKStreamStatusData.h"
#import "PKStreamTaskData.h"
#import "PKMeetingPluginCitrixData.h"
#import "PKMeetingPluginDataFactory.h"
#import "PKEmbedData.h"
#import "PKFileData.h"
#import "PKExternalFileData.h"
#import "PKQuestionData.h"
#import "PKQuestionOptionData.h"
#import "PKLinkedAccountData.h"
#import "PKProviderData.h"
#import "PKSearchResultData.h"
#import "PKByLineData.h"

#pragma mark - Domain objects

#import "PKTask.h"
#import "PKTaskMapping.h"

#pragma mark - Categories

#import "NSArray+PKAdditions.h"
#import "NSDate+PKAdditions.h"
#import "NSDictionary+PKAdditions.h"
#import "NSDictionary+URL.h"
#import "NSError+PKErrors.h"
#import "NSManagedObject+ActiveRecord.h"
#import "NSManagedObject+PKAdditions.h"
#import "NSManagedObjectContext+PKAdditions.h"
#import "NSSet+PKAdditions.h"
#import "NSString+Hash.h"
#import "NSString+PKAdditions.h"
#import "NSString+URL.h"
