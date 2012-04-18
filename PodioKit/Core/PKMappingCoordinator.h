//
//  PKMappingCoordinator.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/14/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKObjectMapper.h"

@interface PKMappingCoordinator : NSObject {

 @private
  PKMappingProvider *mappingProvider_;
}

@property (nonatomic, strong) PKMappingProvider *mappingProvider;

- (PKObjectMapper *)objectMapper;

- (id)initWithMappingProvider:(PKMappingProvider *)mappingProvider;

@end
