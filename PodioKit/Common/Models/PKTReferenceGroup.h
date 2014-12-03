//
//  PKTReferenceSearchGroup.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/12/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@interface PKTReferenceGroup : PKTModel

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSDictionary *data;
@property (nonatomic, copy, readonly) NSArray *contents;

@end
