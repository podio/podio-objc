//
//  PKTAppField.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

typedef NS_ENUM(NSUInteger, PKTAppFieldType) {
  PKTAppFieldTypeNone = 0,
  PKTAppFieldTypeTitle,
  PKTAppFieldTypeText,
  PKTAppFieldTypeNumber,
  PKTAppFieldTypeState,
  PKTAppFieldTypeImage,
  PKTAppFieldTypeMedia,
  PKTAppFieldTypeDate,
  PKTAppFieldTypeApp,
  PKTAppFieldTypeMember,
  PKTAppFieldTypeContact,
  PKTAppFieldTypeMoney,
  PKTAppFieldTypeProgress,
  PKTAppFieldTypeLocation,
  PKTAppFieldTypeVideo,
  PKTAppFieldTypeDuration,
  PKTAppFieldTypeEmbed,
  PKTAppFieldTypeCalculation,
  PKTAppFieldTypeQuestion,
  PKTAppFieldTypeCategory,
};

@interface PKTAppField : PKTModel

@end
