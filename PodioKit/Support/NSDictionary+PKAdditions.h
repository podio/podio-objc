//
//  NSDictionary+POParseTypes.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-01.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (PKAdditions)

- (id)pk_objectForKey:(id)key;

- (id)pk_numberFromStringForKey:(id)key;

- (id)pk_objectForPathComponents:(NSArray *)pathComponents;

- (NSDictionary *)pk_dictionaryByMergingDictionary:(NSDictionary *)dictionary;

@end
