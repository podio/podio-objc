//
//  PKMappableObject.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/27/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/** A requred protocol for every native class that is used as the target domain object class for a PKObjectMapping 
 instance. This protocol is needed by PKObjectMapper to determine things such as object identity.
 */
@protocol PKMappableObject <NSObject>

@required

+ (NSArray *)identityPropertyNames;

@end
