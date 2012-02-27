//
//  PKReferenceStatusData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKObjectData.h"

@interface PKReferenceStatusData : PKObjectData {

 @private
  NSInteger statusId_;
  NSString *value_;
}

@property (nonatomic) NSInteger statusId;
@property (nonatomic, copy) NSString *value;

@end
