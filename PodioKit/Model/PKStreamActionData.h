//
//  PKStreamActionData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKStreamActionData : PKObjectData {

 @private
  NSInteger actionId_;
  PKActionType type_;
  PKReferenceType referenceType_;
  id reference_;
}

@property (nonatomic) NSInteger actionId;
@property (nonatomic) PKActionType type;
@property (nonatomic) PKReferenceType referenceType;
@property (nonatomic, strong) id reference;
@property (nonatomic, copy, readonly) NSString *text;

@end
