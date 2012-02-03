//
//  PKReferenceMeetingData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/2/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKObjectData.h"

@interface PKReferenceMeetingData : PKObjectData {

 @private
  NSInteger meetingId_;
  NSInteger externalId_;
}

@property (nonatomic) NSInteger meetingId;
@property (nonatomic) NSInteger externalId;

@end
