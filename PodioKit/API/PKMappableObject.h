//
//  PKMappableObject.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/27/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PKMappableObject <NSObject>

@required

+ (NSArray *)identityPropertyNames;

@end
