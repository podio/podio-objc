//
//  PKItemFieldValueDataFactory.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/4/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKItemFieldValueDataFactory.h"
#import "PKItemFieldValueContactData.h"
#import "PKItemFieldValueItemData.h"
#import "PKItemFieldValueMoneyData.h"
#import "PKItemFieldValueDateData.h"
#import "PKFileData.h"
#import "PKItemFieldValueEmbedData.h"
#import "PKItemFieldValueMediaData.h"
#import "PKItemFieldValueCalculationData.h"
#import "PKItemFieldValueOptionData.h"
#import "NSDictionary+PKAdditions.h"

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
    case PKAppFieldTypeMedia:
      data = [PKItemFieldValueMediaData dataFromDictionary:dict];
      break;
    case PKAppFieldTypeVideo:
      data = [PKFileData dataFromDictionary:[dict pk_objectForKey:@"value"]];
      break;
    case PKAppFieldTypeCalculation:
      data = [PKItemFieldValueCalculationData dataFromDictionary:dict];
      break;
    case PKAppFieldTypeNumber:
      data = [dict pk_numberFromStringForKey:@"value"];
      break;
    case PKAppFieldTypeState: {
      PKItemFieldValueOptionData *optionData = [PKItemFieldValueOptionData data];
      
      optionData.optionId = -1; // No option id
      optionData.text = [dict pk_objectForKey:@"value"];
      optionData.selected = YES;
      
      data = optionData;
      break;
    }
    case PKAppFieldTypeCategory: {      
      data = [PKItemFieldValueOptionData dataFromDictionary:[dict pk_objectForKey:@"value"]];
      break;
    }
    case PKAppFieldTypeQuestion: {
      PKItemFieldValueOptionData *optionData = [PKItemFieldValueOptionData data];
      
      NSDictionary *answerDict = [dict pk_objectForKey:@"value"];
      optionData.optionId = [[answerDict pk_objectForKey:@"id"] integerValue];
      optionData.text = [answerDict pk_objectForKey:@"text"];
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
