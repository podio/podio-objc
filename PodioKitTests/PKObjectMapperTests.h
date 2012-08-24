//
//  PKObjectMapperTests.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/21/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

//  Logic unit tests contain unit test code that is designed to be linked into an independent test executable.
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <SenTestingKit/SenTestingKit.h>
#import "PKMappingProvider.h"

@interface PKObjectMapperTests : SenTestCase {

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
