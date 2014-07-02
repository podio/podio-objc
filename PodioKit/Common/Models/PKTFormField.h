//
//  PKTFormField.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@interface PKTFormField : PKTModel

@property (nonatomic, assign, readonly) NSUInteger fieldID;
@property (nonatomic, assign, readonly) NSDictionary *settings;

@end
