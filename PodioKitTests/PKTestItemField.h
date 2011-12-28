//
//  PKTestItemField.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/21/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKMappableObject.h"

@interface PKTestItemField : NSObject <PKMappableObject> {
  
 @private
  NSNumber *fieldId_;
  NSString *text_;
}

@property (nonatomic, copy) NSNumber *fieldId;
@property (nonatomic, copy) NSString *text;

@end
