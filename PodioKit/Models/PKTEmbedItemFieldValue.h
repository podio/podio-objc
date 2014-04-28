//
//  PKTEmbedItemFieldValue.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTItemFieldValue.h"

@class PKTEmbed;
@class PKTFile;

@interface PKTEmbedItemFieldValue : PKTItemFieldValue

@property (nonatomic, strong) PKTEmbed *embed;
@property (nonatomic, strong, readonly) PKTFile *file;

@end
