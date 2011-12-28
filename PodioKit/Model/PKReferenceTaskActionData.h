//
//  POStreamActivityTaskActionData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKObjectData.h"

@interface PKReferenceTaskActionData : PKObjectData {

 @private
  NSInteger taskActionId_;
  PKTaskActionType type_;
  NSString *changed_;
}

@property (nonatomic) NSInteger taskActionId;
@property (nonatomic) PKTaskActionType type;
@property (nonatomic, copy) NSString *changed;

@end
