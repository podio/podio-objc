//
//  POStreamActivityAnswerData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKObjectData.h"

@interface PKStreamActivityAnswerData : PKObjectData {

 @private
  NSInteger optionId_;
  NSString *text_;
}

@property (nonatomic) NSInteger optionId;
@property (nonatomic, copy) NSString *text;

@end
