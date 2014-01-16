//
//  PKSyncManager.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKAPIClient.h"
#import "PKMappingCoordinator.h"
#import "PKHTTPRequestOperation.h"

@interface PKRequestManager : NSObject

@property (nonatomic, strong) PKAPIClient *apiClient;
@property (nonatomic, strong) PKMappingCoordinator *mappingCoordinator;

+ (PKRequestManager *)sharedManager;

- (void)configureWithClient:(PKAPIClient *)client mappingCoordinator:(PKMappingCoordinator *)coordinator;

- (PKHTTPRequestOperation *)performRequest:(PKRequest *)request completion:(PKRequestCompletionBlock)completion;

@end
