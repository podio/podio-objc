//
//  PKTReferenceObjectFactory.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 30/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKTReferenceObjectFactory : NSObject

+ (id)referenceObjectFromDictionary:(NSDictionary *)dictionary;
+ (id)referenceObjectFromData:(NSDictionary *)data type:(NSUInteger)referenceType;

@end
