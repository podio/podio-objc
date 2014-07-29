//
//  PKGrantData.h
//  PodioKit
//
//  Created by Romain Briche on 28/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <PodioKit/PodioKit.h>

@interface PKGrantData : PKObjectData

@property (nonatomic, assign, readonly) NSUInteger grantId;
@property (nonatomic, assign, readonly) PKGrantAction action;
@property (nonatomic, copy, readonly) NSString *message;
@property (nonatomic, copy, readonly) NSDate *createdOn;
@property (nonatomic, strong, readonly) PKByLineData *createdBy;
@property (nonatomic, assign, readonly) PKReferenceType referenceType;
@property (nonatomic, assign, readonly) NSUInteger referenceId;
@property (nonatomic, strong, readonly) PKObjectData *referenceData;

@end
