//
//  PKAppFieldEmailData.h
//  PodioKit
//
//  Created by Pavel Prochazka on 09/06/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKAppFieldEmailData : PKObjectData {
  
@private
  BOOL includeInBcc_;
  BOOL includeInCc_;
}

@property (nonatomic, assign) BOOL includeInBcc;
@property (nonatomic, assign) BOOL includeInCc;

@end