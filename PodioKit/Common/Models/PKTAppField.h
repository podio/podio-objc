//
//  PKTAppField.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"
#import "PKTConstants.h"
#import "PKTAppFieldConfig.h"

@class PKTCategoryOption;

@interface PKTAppField : PKTModel

@property (nonatomic, assign, readonly) NSUInteger fieldID;
@property (nonatomic, copy, readonly) NSString *externalID;
@property (nonatomic, assign, readonly) PKTAppFieldType type;
@property (nonatomic, strong, readonly) PKTAppFieldConfig *config;

- (instancetype)initWithFieldID:(NSUInteger)fieldID externalID:(NSString *)externalID type:(PKTAppFieldType)type config:(PKTAppFieldConfig *)config;

#pragma mark - Public

- (PKTCategoryOption *)categoryOptionWithID:(NSUInteger)optionID;

@end
