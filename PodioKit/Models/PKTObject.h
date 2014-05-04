//
//  PKTObject.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 31/03/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"
#import "PKTClient.h"

@interface PKTObject : PKTModel

+ (PKTClient *)client;
+ (void)setClient:(PKTClient *)client;

@end
