//
//  PKReferenceAlertData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/7/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKReferenceAlertData : PKObjectData {
  
 @private
  NSString *text_;
}

@property (nonatomic, copy) NSString *text;

@end
