//
//  PKStreamActivityDataFactory.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKStreamActivityDataFactory : NSObject

+ (id)dataFromDictionary:(NSDictionary *)dict activityType:(PKStreamActivityType)activityType;

@end
