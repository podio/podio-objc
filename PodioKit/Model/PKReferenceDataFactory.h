//
//  PKReferenceDataFactory.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/21/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKReferenceDataFactory : NSObject

+ (id)dataForDictionary:(NSDictionary *)dict referenceType:(PKReferenceType)referenceType;

@end
