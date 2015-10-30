//
//  PKItemFieldValueTagData.h
//  PodioKit
//
//  Created by Pavel Prochazka on 30/10/15.
//  Copyright © 2015 Citrix Systems, Inc. All rights reserved.
//

#import <PodioKit-1.x/PodioKit-1.x.h>

@interface PKItemFieldValueTagData : PKObjectData {
  
@private
  NSArray *tags_;
}

@property (nonatomic, copy) NSArray *tags;
@property (nonatomic, copy, readonly) NSDictionary *valueDictionary;

@end
