//
//  PKTEmbed.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"
#import "PKTConstants.h"

@interface PKTEmbed : PKTModel

@property (nonatomic, assign, readonly) NSUInteger embedID;
@property (nonatomic, copy, readonly) NSURL *originalURL;
@property (nonatomic, copy, readonly) NSURL *resolvedURL;
@property (nonatomic, assign, readonly) PKTEmbedType type;
@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSString *descr;
@property (nonatomic, copy, readonly) NSDate *createdOn;
@property (nonatomic, copy, readonly) NSString *providerName;
@property (nonatomic, copy, readonly) NSString *embedHTML;
@property (nonatomic, assign, readonly) NSNumber *embedWidth;
@property (nonatomic, assign, readonly) NSNumber *embedHeight;
@property (nonatomic, copy, readonly) NSString *files;

@end
