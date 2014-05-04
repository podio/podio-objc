//
//  NSJSONSerialization+PKTAdditions.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSJSONSerialization (PKTAdditions)

+ (id)pkt_JSONObjectFromFileWithName:(NSString *)fileName inBundleForClass:(Class)klass;

@end
