//
//  PKDemoTask.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 4/6/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKBaseObject.h"

@interface PKDemoTask : PKBaseObject

@property (nonatomic) NSUInteger taskId;
@property (nonatomic, copy) NSString *text;
@property (nonatomic) PKTaskStatus status;
@property (nonatomic, strong) NSDate *createdOn;

@end
