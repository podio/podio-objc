//
//  PKStreamObject.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/11/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKBaseObject.h"

@interface PKStreamObject : PKBaseObject {

 @private
  PKReferenceType objectType_;
  NSUInteger objectId_;
  NSString *title_;
}

@property (nonatomic) PKReferenceType objectType;
@property (nonatomic) NSUInteger objectId;
@property (nonatomic, copy) NSString *title;

@end
