//
//  PKItemFieldValueDataFactory.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/4/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKItemFieldValueDataFactory.h"
#import "PKItemFieldValueContactData.h"
#import "PKItemFieldValueItemData.h"
#import "PKItemFieldValueMoneyData.h"
#import "PKItemFieldValueDateData.h"
#import "PKFileData.h"
#import "PKItemFieldValueEmbedData.h"
#import "PKItemFieldValueCalculationData.h"
#import "PKItemFieldValueOptionData.h"
#import "NSDictionary+PKAdditions.h"
#import "NSNumber+PKFormat.h"

@implementation PKItemFieldValueDataFactory

+ (id)dataFromDictionary:(NSDictionary *)dict fieldType:(PKAppFieldType)fieldType {
  id data = nil;
  
  switch (fieldType) {
    case PKAppFieldTypeContact:
      data = [PKItemFieldValueContactData dataFromDictionary:dict];
      break; 
    case PKAppFieldTypeApp:
      data = [PKItemFieldValueItemData dataFromDictionary:dict];
      break;
    case PKAppFieldTypeMoney:
      data = [PKItemFieldValueMoneyData dataFromDictionary:dict];
      break;
    case PKAppFieldTypeDate:
      data = [PKItemFieldValueDateData dataFromDictionary:dict];
      break;
    case PKAppFieldTypeImage:
      data = [PKFileData dataFromDictionary:[dict pk_objectForKey:@"value"]];
      break;
    case PKAppFieldTypeEmbed:
      data = [PKItemFieldValueEmbedData dataFromDictionary:dict];
      break;
    case PKAppFieldTypeVideo:
      data = [PKFileData dataFromDictionary:[dict pk_objectForKey:@"value"]];
      break;
    case PKAppFieldTypeCalculation:
      data = [PKItemFieldValueCalculationData dataFromDictionary:dict];
      break;
    case PKAppFieldTypeNumber:
      data = [NSNumber pk_numberFromStringWithUSLocale:[dict pk_objectForKey:@"value"]];
      break;
    case PKAppFieldTypeCategory: {      
      PKItemFieldValueOptionData *optionData = [PKItemFieldValueOptionData dataFromDictionary:[dict pk_objectForKey:@"value"]];
      optionData.selected = YES;
      
      data = optionData;
      break;
    }
    case PKAppFieldTypeText:
    case PKAppFieldTypeDuration:
    case PKAppFieldTypeLocation:
    case PKAppFieldTypeProgress:
      data = [dict pk_objectForKey:@"value"];
      break;
    default:
      break;
  }
  
  return data;
}

@end
