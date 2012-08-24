//
//  PKMappingCoordinator.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/14/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKObjectMapper.h"

/** The mapping coordinator is responsible for providing each new request operation with an new object mapper. This is 
 needed because a single NSManagedObjectContext instance can only be used on the thread that instantiated it. Hence, 
 PodioKit needs to create a new object context for each concurrent background operation.
 */
@interface PKMappingCoordinator : NSObject {

 @private
  PKMappingProvider *mappingProvider_;
}

@property (nonatomic, strong) PKMappingProvider *mappingProvider;

- (PKObjectMapper *)objectMapper;

- (id)initWithMappingProvider:(PKMappingProvider *)mappingProvider;

@end
