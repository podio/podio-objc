//
//  PKTModel.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKTModel : NSObject <NSCoding, NSCopying>

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (void)updateFromDictionary:(NSDictionary *)dictionary;

// Override in subclass to define how to map
+ (NSDictionary *)dictionaryKeyPathsForPropertyNames;

@end
