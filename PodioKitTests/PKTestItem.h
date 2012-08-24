//
//  PKTestItem.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/21/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKMappableObject.h"
#import "PKTestItemApp.h"

@interface PKTestItem : NSObject <PKMappableObject> {

 @private
  NSNumber *itemId_;
  NSString *title_;
  NSArray *fields_;
  PKTestItemApp *app_;
}

@property (nonatomic, copy) NSNumber *itemId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *fields;
@property (nonatomic, strong) PKTestItemApp *app;

@end
