//
//  PKAppFieldContactData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/7/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"


@interface PKAppFieldContactData : PKObjectData {

 @private
  NSArray *validTypes_;
}

@property (nonatomic, strong) NSArray *validTypes;

@end
