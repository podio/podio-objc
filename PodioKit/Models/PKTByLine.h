//
//  PKTByLine.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 08/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"
#import "PKTConstants.h"

@class PKTFile;

@interface PKTByLine : PKTModel

@property (nonatomic, assign, readonly) PKTReferenceType referenceType;
@property (nonatomic, assign, readonly) NSUInteger referenceID;
@property (nonatomic, assign, readonly) NSInteger userID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, strong) PKTFile *imageFile;

@end
