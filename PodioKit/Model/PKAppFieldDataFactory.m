//
//  PKAppFieldDataFactory.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 4/11/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKAppFieldDataFactory.h"
#import "PKAppFieldOptionsData.h"
#import "PKItemFieldValueOptionData.h"
#import "PKAppFieldMoneyData.h"
#import "PKAppFieldContactData.h"
#import "NSDictionary+PKAdditions.h"

@implementation PKAppFieldDataFactory

+ (id)dataFromDictionary:(NSDictionary *)dict type:(PKAppFieldType)type {
  id data = nil;
  
  NSDictionary *configDict = [dict pk_objectForKey:@"config"];
  
  switch (type) {
    case PKAppFieldTypeCategory: {
      PKAppFieldOptionsData *optionsData = [PKAppFieldOptionsData data];
      NSDictionary *settingsDict = [configDict pk_objectForKey:@"settings"];
      
      optionsData.multiple = [[settingsDict pk_objectForKey:@"multiple"] boolValue];
      
      NSMutableArray *options = [[NSMutableArray alloc] init];
      for (NSDictionary *optionsDict in [settingsDict pk_objectForKey:@"options"]) {
        if ([[optionsDict pk_objectForKey:@"status"] isEqualToString:@"active"]) {
          // Add active options
          PKItemFieldValueOptionData *option = [PKItemFieldValueOptionData dataFromDictionary:optionsDict];
          [options addObject:option];
        }
      }
      
      optionsData.options = options;
      
      data = optionsData;
      break;
    }
    case PKAppFieldTypeMoney: {
      PKAppFieldMoneyData *moneyData = [PKAppFieldMoneyData data];
      moneyData.allowedCurrencies = [[configDict pk_objectForKey:@"settings"] pk_objectForKey:@"allowed_currencies"];
      data = moneyData;
      break;
    }
    case PKAppFieldTypeContact: {
      PKAppFieldContactData *contactData = [PKAppFieldContactData data];
      contactData.validTypes = [[configDict pk_objectForKey:@"settings"] pk_objectForKey:@"valid_types"];
      data = contactData;
      break;
    }
    default:
      break;
  }
  
  return data;
}

@end
