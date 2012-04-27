//
//  PKObjectMapperTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/21/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKObjectMapperTests.h"
#import "PKObjectMapper.h"
#import "PKTestMappingProvider.h"
#import "PKDefaultObjectRepository.h"
#import "PKTestItem.h"
#import "PKTestItemMapping.h"
#import "PKTestItemFieldMapping.h"
#import "PKTestItemAppMapping.h"

@interface PKObjectMapperTests ()

- (PKObjectMapper *)createObjectMapper;

@end

@implementation PKObjectMapperTests

@synthesize mappingProvider = mappingProvider_;

- (void)setUp {
  // TODO: Build mapping provider
  self.mappingProvider = [[PKTestMappingProvider alloc] init];
}

- (void)tearDown {
  self.mappingProvider = nil;
}

- (void)testSingleObjectMapping {
  PKObjectMapper *mapper = [self createObjectMapper];
  mapper.mapping = [PKTestItemMapping mapping];
  
  NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                        [NSNumber numberWithInt:1234], @"item_id", 
                        @"This is an item title", @"title", nil];
  
  id result = [mapper performMappingWithData:data];
  STAssertTrue([result isKindOfClass:[PKTestItem class]], @"Wrong class, got %@", [result class]);
  
  PKTestItem *item = (PKTestItem *)result;
  STAssertTrue([item.itemId intValue] == 1234, @"Item id does not match, got %d", [item.itemId intValue]);
  STAssertTrue([item.title isEqualToString:@"This is an item title"], @"Item title does not match, got %@", item.title);
}

- (void)testCollectionMapping {
  PKObjectMapper *mapper = [self createObjectMapper];
  mapper.mapping = [PKTestItemMapping mapping];
  
  NSArray *data = [NSArray arrayWithObjects:
                   [NSDictionary dictionaryWithObjectsAndKeys:
                    [NSNumber numberWithInt:1234], @"item_id", 
                    @"This is an item title 1", @"title", nil], 
                   [NSDictionary dictionaryWithObjectsAndKeys:
                    [NSNumber numberWithInt:1111], @"item_id",  // According to item mapping this object should be skipped because id == 1111
                    @"This is an item title 2", @"title", nil], 
                   [NSDictionary dictionaryWithObjectsAndKeys:
                    [NSNumber numberWithInt:4321], @"item_id", 
                    @"This is an item title 3", @"title", nil], nil];
  
  id result = [mapper performMappingWithData:data];
  STAssertTrue([result isKindOfClass:[NSArray class]], @"Wrong class, got %@", [result class]);
  STAssertTrue([result count] == 2, @"Result should contain 2 items, got %@", [result count]);
  
  PKTestItem *item1 = (PKTestItem *)[result objectAtIndex:0];
  PKTestItem *item2 = (PKTestItem *)[result objectAtIndex:1];
  
  STAssertTrue([item1.itemId intValue] == 1234, @"Item id does not match, got %d", [item2.itemId intValue]);
  STAssertTrue([item1.title isEqualToString:@"This is an item title 1"], @"Item title does not match, got %@", item1.title);
  
  STAssertTrue([item2.itemId intValue] == 4321, @"Item id does not match, got %d", [item2.itemId intValue]);
  STAssertTrue([item2.title isEqualToString:@"This is an item title 3"], @"Item title does not match, got %@", item2.title);
}

- (void)testValueMapping {
  PKObjectMapper *mapper = [self createObjectMapper];
  
  PKTestItem *item = [[PKTestItem alloc] init];
  STAssertTrue(item.itemId == nil, @"Item id should be nil");
  STAssertTrue(item.title == nil, @"Item title should be nil");
  
  // Value mapping of id
  PKValueMapping *idMapping = [[PKValueMapping alloc] initWithPropertyName:@"itemId" attributeName:@"item_id"];
  [mapper applyAttributeMapping:idMapping attributeValue:[NSNumber numberWithInt:3333] object:item objectDict:nil parentObject:nil];
  STAssertTrue([item.itemId intValue] == 3333, @"Item id does not match, got %d", [item.itemId intValue]);
  
  // Value mapping of title
  PKValueMapping *titleMapping = [[PKValueMapping alloc] initWithPropertyName:@"title" attributeName:@"title"];
  [mapper applyAttributeMapping:titleMapping attributeValue:@"This is an item title" object:item objectDict:nil parentObject:nil];
  STAssertTrue([item.title isEqualToString:@"This is an item title"], @"Item title does not match, got %@", item.title);
  
  // Value mapping with block
  PKValueMapping *blockMapping = [[PKValueMapping alloc] initWithPropertyName:@"title" attributeName:@"title" block:^id(id attrVal, NSDictionary *objDict, id parent) {
    return [NSString stringWithFormat:@"%@ - Appending some text", attrVal];
  }];
  [mapper applyAttributeMapping:blockMapping attributeValue:@"This is an item title" object:item objectDict:nil parentObject:nil];
  STAssertTrue([item.title isEqualToString:@"This is an item title - Appending some text"], @"Item title does not match, got %@", item.title);
}

- (void)testOneToManyRelationshipMapping {
  PKObjectMapper *mapper = [self createObjectMapper];
  
  PKTestItem *item = [[PKTestItem alloc] init];
  
  // One-to-many
  NSArray *data = [NSArray arrayWithObjects:
                         [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithInt:1234], @"field_id", 
                          @"Field text 1", @"text", nil], 
                         [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithInt:4321], @"field_id", 
                          @"Field text 2", @"text", nil], nil];
  
  PKRelationshipMapping *mapping = [[PKRelationshipMapping alloc] initWithPropertyName:@"fields" attributeName:@"fields" inverseProperty:nil objectMapping:[PKTestItemFieldMapping mapping]];
  [mapper applyRelationshipMapping:mapping attributeValue:data object:item];
  
  STAssertTrue([item.fields count] == 2, @"Item field count does not match, got %d", [item.fields count]);
}

- (void)testOneToOneRelationshipMapping {
  PKObjectMapper *mapper = [self createObjectMapper];
  
  PKTestItem *item = [[PKTestItem alloc] init];
  
  NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:
                           [NSNumber numberWithInt:4444], @"app_id", 
                           @"Bugs", @"name", nil];
  
  PKRelationshipMapping *mapping = [[PKRelationshipMapping alloc] initWithPropertyName:@"app" attributeName:@"app" inverseProperty:nil objectMapping:[PKTestItemAppMapping mapping]];
  [mapper applyRelationshipMapping:mapping attributeValue:data object:item];
  STAssertTrue(item.app != nil, @"App should not be nil");
  STAssertTrue([item.app.appId intValue] == 4444, @"App id does not match, got %d", [item.app.appId intValue]);
  STAssertTrue([item.app.name isEqualToString:@"Bugs"], @"App title does not match, got %@", item.app.name);
}

#pragma mark - Helpers

- (PKObjectMapper *)createObjectMapper {
  PKDefaultObjectRepository *repository = [[PKDefaultObjectRepository alloc] init];
  PKObjectMapper *objectMapper = [[PKObjectMapper alloc] initWithProvider:self.mappingProvider repository:repository];
  
  return objectMapper;
}

@end
