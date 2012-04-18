//
//  PKReferenceBatchData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 4/18/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKObjectData.h"
#import "PKReferenceAppData.h"

@interface PKReferenceBatchData : PKObjectData

@property (nonatomic) NSInteger batchId;
@property (nonatomic, copy) NSString *plugin;
@property (nonatomic, retain) PKReferenceAppData *app;

@end
