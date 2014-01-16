//
//  PKObjectMapperTests.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/21/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKMappingProvider.h"

@interface PKObjectMapperTests : XCTestCase {

 @private
  PKMappingProvider *mappingProvider_;
}

@property (nonatomic, strong) PKMappingProvider *mappingProvider;

- (void)testSingleObjectMapping;
- (void)testCollectionMapping;

- (void)testValueMapping;
- (void)testOneToManyRelationshipMapping;
- (void)testOneToOneRelationshipMapping;

@end
