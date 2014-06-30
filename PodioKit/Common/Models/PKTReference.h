//
//  PKTReference.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 30/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"
#import "PKTConstants.h"

@interface PKTReference : PKTModel

@property (nonatomic, assign, readonly) NSUInteger referenceID;
@property (nonatomic, assign, readonly) PKTReferenceType referenceType;
@property (nonatomic, strong, readonly) id referenceObject;

@end
