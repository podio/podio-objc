//
//  PKReferenceAppData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/1/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKObjectData.h"

@interface PKReferenceAppData : PKObjectData {
  
 @private
  NSInteger appId_;
  NSString *name_;
  NSString *icon_;
}

@property (nonatomic) NSInteger appId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;

@end
