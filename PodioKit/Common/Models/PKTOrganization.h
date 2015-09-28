//
//  PKTOrganization.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"
#import "PKTConstants.h"

@class PKTFile, PKTAsyncTask;

@interface PKTOrganization : PKTModel

@property (nonatomic, assign, readonly) NSUInteger organizationID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSArray *workspaces;
@property (nonatomic, strong, readonly) PKTFile *imageFile;
@property (nonatomic, assign, readonly) PKTRight rights;

#pragma mark - API

+ (PKTAsyncTask *)fetchAll;
+ (PKTAsyncTask *)fetchWithID:(NSUInteger)organizationID;
+ (PKTAsyncTask *)updateOrganizationWithID:(NSUInteger)organizationID withName:(NSString *)name;

@end
