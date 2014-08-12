//
//  PKTApp.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 03/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@class PKTAppField, PKTAsyncTask;

@interface PKTApp : PKTModel

@property (nonatomic, readonly) NSUInteger appID;
@property (nonatomic, readonly) NSUInteger spaceID;
@property (nonatomic, readonly) NSUInteger iconID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *itemName;
@property (nonatomic, copy, readonly) NSString *appDescription;
@property (nonatomic, copy, readonly) NSURL *link;
@property (nonatomic, copy, readonly) NSArray *fields;

+ (PKTAsyncTask *)fetchAppWithID:(NSUInteger)appID;
+ (PKTAsyncTask *)fetchAppsInWorkspaceWithID:(NSUInteger)spaceID;

- (PKTAppField *)fieldWithExternalID:(NSString *)externalID;

@end
