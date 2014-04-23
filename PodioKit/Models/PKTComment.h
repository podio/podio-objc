//
//  PKTComment.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTObject.h"
#import "PKTConstants.h"

@interface PKTComment : PKTObject

@property (nonatomic, readonly) NSUInteger commentID;
@property (nonatomic, readonly) PKTReferenceType referenceType;
@property (nonatomic, readonly) NSUInteger referenceID;
@property (nonatomic, copy, readonly) NSString *value;
@property (nonatomic, copy, readonly) NSString *richValue;

@end
