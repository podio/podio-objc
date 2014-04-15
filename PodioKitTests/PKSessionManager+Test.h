//
//  PKSessionManager+Test.h
//  PodioKit
//
//  Created by Romain Briche on 30/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTSessionManager.h"

@interface PKTSessionManager (Test)

- (void)refreshSessionToken:(PKTRequestCompletionBlock)completion;

@end
