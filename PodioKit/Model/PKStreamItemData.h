//
//  POStreamItemData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKObjectData.h"


@interface PKStreamItemData : PKObjectData {

 @private
  NSInteger itemId_;
  NSString *title_;
}

@property (nonatomic) NSInteger itemId;
@property (nonatomic, copy) NSString *title;

@end
