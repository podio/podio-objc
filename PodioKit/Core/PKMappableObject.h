//
//  PKMappableObject.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/27/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PKMappableObject <NSObject>

@required

+ (NSArray *)identityPropertyNames;

@end
