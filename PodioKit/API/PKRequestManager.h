//
//  POSyncManager.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKAPIClient.h"
#import "PKMappingManager.h"
#import "PKRequestOperation.h"

@interface PKRequestManager : NSObject {

 @private
  PKAPIClient *apiClient_;
  PKMappingManager *mappingManager_;
}

@property (nonatomic, strong) PKAPIClient *apiClient;
@property (nonatomic, strong) PKMappingManager *mappingManager;

+ (PKRequestManager *)sharedManager;

- (PKRequestOperation *)performRequest:(PKRequest *)request completion:(PKRequestCompletionBlock)completion;

@end
