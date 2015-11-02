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
  NSString *tag_;
}

@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy, readonly) NSDictionary *valueDictionary;

@end
