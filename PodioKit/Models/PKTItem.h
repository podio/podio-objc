//
//  PKTItem.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 31/03/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTObject.h"

@interface PKTItem : PKTObject

@property (nonatomic, assign, readonly) NSUInteger itemID;
@property (nonatomic, assign, readonly) NSUInteger appID;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSArray *fields;
@property (nonatomic, copy, readonly) NSArray *files;
@property (nonatomic, copy, readonly) NSArray *comments;

+ (instancetype)itemForAppWithID:(NSUInteger)appID;

#pragma mark - API

+ (void)fetchItemWithID:(NSUInteger)itemID completion:(void (^)(PKTItem *item, NSError *error))completion;
- (void)saveWithCompletion:(PKTRequestCompletionBlock)completion;

#pragma mark - Public

- (void)setValue:(id)value forField:(NSString *)externalID;
- (id)valueForField:(NSString *)externalID;

#pragma mark - Subscripting for item fields

- (id)objectForKeyedSubscript:(id <NSCopying>)key;
- (void)setObject:(id)obj forKeyedSubscript:(id <NSCopying>)key;

@end
