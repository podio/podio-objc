//
//  PKTForm.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

typedef NS_ENUM(NSUInteger, PKTFormStatus) {
  PKTFormStatusActive,
  PKTFormStatusDeleted,
  PKTFormStatusDisabled
};

@class PKTFormSettings, PKTAsyncTask;

@interface PKTForm : PKTModel

@property (nonatomic, assign, readonly) NSUInteger formID;
@property (nonatomic, assign, readonly) NSUInteger spaceID;
@property (nonatomic, assign, readonly) NSUInteger appID;
@property (nonatomic, assign, readonly) PKTFormStatus status;
@property (nonatomic, assign, readonly) BOOL hasItemCapacity;
@property (nonatomic, assign, readonly) BOOL allowsAttachments;
@property (nonatomic, copy, readonly) PKTFormSettings *settings;
@property (nonatomic, copy, readonly) NSArray *fields; // An array of PKTFormField objects

+ (PKTAsyncTask *)fetchWithID:(NSUInteger)formID;

@end
