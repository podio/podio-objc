//
//  PKTReference.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 30/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"
#import "PKTReferenceAPI.h"
#import "PKTConstants.h"

@class PKTAsyncTask;

@interface PKTReference : PKTModel

@property (nonatomic, assign, readonly) NSUInteger referenceID;
@property (nonatomic, assign, readonly) PKTReferenceType referenceType;
@property (nonatomic, strong, readonly) id referenceObject;

+ (PKTAsyncTask *)searchForReferenceWithText:(NSString *)text target:(PKTReferenceTarget)target targetParameters:(NSDictionary *)targetParamers limit:(NSUInteger)limit;

@end
