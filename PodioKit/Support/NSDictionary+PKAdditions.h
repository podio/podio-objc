//
//  NSDictionary+PKAdditions.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-01.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (PKAdditions)

- (id)pk_objectForKey:(id)key;

- (id)pk_objectForPathComponents:(NSArray *)pathComponents;

- (NSDictionary *)pk_dictionaryByMergingDictionary:(NSDictionary *)dictionary;

@end
