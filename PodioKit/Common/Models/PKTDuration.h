//
//  PKTDuration 
//  PodioKit
//
//  Created by Sebastian Rehnby on 15/05/14
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@interface PKTDuration : PKTModel

@property (nonatomic, assign) NSUInteger hours;
@property (nonatomic, assign) NSUInteger minutes;
@property (nonatomic, assign) NSUInteger seconds;
@property (nonatomic, assign) NSUInteger totalSeconds;

- (instancetype)initWithHours:(NSUInteger)hours minutes:(NSUInteger)minutes seconds:(NSUInteger)seconds;
- (instancetype)initWithTotalSeconds:(NSUInteger)totalSeconds;

@end