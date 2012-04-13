//
//  PKItemFieldValueDataFactory.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/4/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKItemFieldValueDataFactory : NSObject

+ (id)dataFromDictionary:(NSDictionary *)dict fieldType:(PKAppFieldType)fieldType;

@end
