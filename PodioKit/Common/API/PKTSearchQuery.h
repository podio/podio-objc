//
//  PKTSearchQuery.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTRequestParameters.h"
#import "PKTConstants.h"

@interface PKTSearchQuery : NSObject <PKTRequestParameters>

@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, assign) PKTReferenceType referenceType;
@property (nonatomic, assign) BOOL returnCounts;

+ (instancetype)queryWithText:(NSString *)text;

@end