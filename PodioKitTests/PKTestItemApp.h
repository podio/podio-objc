//
//  PKTestItemApp.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/21/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKMappableObject.h"

@interface PKTestItemApp : NSObject <PKMappableObject> {
  
@private
  NSNumber *appId_;
  NSString *name_;
}

@property (nonatomic, copy) NSNumber *appId;
@property (nonatomic, copy) NSString *name;

@end
