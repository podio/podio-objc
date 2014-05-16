//
//  PKTAppField.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@class PKTAppFieldConfig;

typedef NS_ENUM(NSUInteger, PKTAppFieldType) {
  PKTAppFieldTypeNone = 0,
  PKTAppFieldTypeTitle,
  PKTAppFieldTypeText,
  PKTAppFieldTypeNumber,
  PKTAppFieldTypeImage,
  PKTAppFieldTypeDate,
  PKTAppFieldTypeApp,
  PKTAppFieldTypeContact,
  PKTAppFieldTypeMoney,
  PKTAppFieldTypeProgress,
  PKTAppFieldTypeLocation,
  PKTAppFieldTypeDuration,
  PKTAppFieldTypeEmbed,
  PKTAppFieldTypeCalculation,
  PKTAppFieldTypeCategory,
};

@interface PKTAppField : PKTModel

@property (nonatomic, assign, readonly) NSUInteger fieldID;
@property (nonatomic, copy, readonly) NSString *externalID;
@property (nonatomic, assign, readonly) PKTAppFieldType type;
@property (nonatomic, strong, readonly) PKTAppFieldConfig *config;

- (instancetype)initWithFieldID:(NSUInteger)fieldID externalID:(NSString *)externalID type:(PKTAppFieldType)type;

@end
