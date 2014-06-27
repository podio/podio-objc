//
//  PKTReferenceIdentifier.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTConstants.h"

@interface PKTReferenceIdentifier : NSObject <NSCopying>

@property (nonatomic, assign, readonly) NSUInteger referenceID;
@property (nonatomic, assign, readonly) PKTReferenceType referenceType;
@property (nonatomic, copy, readonly) NSString *referenceTypeString;

+ (instancetype)identifierWithReferenceID:(NSUInteger)referenceID type:(PKTReferenceType)referenceType;

@end
