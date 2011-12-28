//
//  POAppFieldContactData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/7/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKObjectData.h"


@interface PKAppFieldContactData : PKObjectData {

 @private
  NSArray *validTypes_;
}

@property (nonatomic, retain) NSArray *validTypes;

@end
