//
//  PKSyncManager.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKAPIClient2.h"
#import "PKMappingCoordinator.h"
#import "PKHTTPRequestOperation.h"

@interface PKRequestManager : NSObject

@property (nonatomic, strong) PKAPIClient2 *apiClient;
@property (nonatomic, strong) PKMappingCoordinator *mappingCoordinator;

+ (PKRequestManager *)sharedManager;

- (void)configureWithClient:(PKAPIClient2 *)client mappingCoordinator:(PKMappingCoordinator *)coordinator;

- (PKHTTPRequestOperation *)performRequest:(PKRequest *)request completion:(PKRequestCompletionBlock)completion;

@end
