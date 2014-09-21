//
//  PKDate+Formatting.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 21/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKDate.h"

@interface PKDate (PKFormatting)

- (NSString *)pk_UTCDateTimeString;

- (NSString *)pk_UTCDateString;

- (NSString *)pk_UTCTimeString;

@end
