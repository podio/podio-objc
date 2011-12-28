//
//  PKTask.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/11/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKBaseObject.h"
#import "PKRequestOperation.h"

@interface PKTask : PKBaseObject {

 @private
  NSUInteger taskId_;
  NSString *text_;
  PKTaskType type_;
  PKTaskStatus status_;
  NSDate *createdOn_;
}

@property (nonatomic) NSUInteger taskId;
@property (nonatomic, copy) NSString *text;
@property (nonatomic) PKTaskType type;
@property (nonatomic) PKTaskStatus status;
@property (nonatomic, retain) NSDate *createdOn;

@end
