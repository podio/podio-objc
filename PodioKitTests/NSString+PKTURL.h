//
//  NSString+PKTURL.h
//  PodioKit
//
//  Created by Romain Briche on 22/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PKTURL)

- (instancetype)pkt_escapedURLString;
- (instancetype)pkt_unescapedURLString;

@end
