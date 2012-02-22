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
  PKMeetingPluginType pluginType_;
  id pluginData_;
}

@property (nonatomic) NSInteger meetingId;
@property (nonatomic) PKMeetingPluginType pluginType;
@property (nonatomic, strong) id pluginData;

@end
