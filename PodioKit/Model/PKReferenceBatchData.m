//
//  PKReferenceBatchData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 4/18/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKReferenceBatchData.h"


static NSString * const PKReferenceBatchDataBatchId = @"BatchId";
static NSString * const PKReferenceBatchDataPlugin = @"Plugin";
static NSString * const PKReferenceBatchDataApp = @"App";

@implementation PKReferenceBatchData

@synthesize batchId = batchId_;
@synthesize plugin = plugin_;
@synthesize app = app_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    batchId_ = [aDecoder decodeIntForKey:PKReferenceBatchDataBatchId];
    plugin_ = [[aDecoder decodeObjectForKey:PKReferenceBatchDataPlugin] copy];
    app_ = [aDecoder decodeObjectForKey:PKReferenceBatchDataApp];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:batchId_ forKey:PKReferenceBatchDataBatchId];
  [aCoder encodeObject:plugin_ forKey:PKReferenceBatchDataPlugin];
  [aCoder encodeObject:app_ forKey:PKReferenceBatchDataApp];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceBatchData *data = [self data];
  
  data.batchId = [[dict pk_objectForKey:@"batch_id"] integerValue];
  data.plugin = [dict pk_objectForKey:@"plugin"];
  data.app = [PKReferenceAppData dataFromDictionary:[dict pk_objectForKey:@"app"]];
  
  return data;
}

@end
