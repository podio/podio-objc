//
//  PKMeetingPluginCitrixData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/7/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKObjectData.h"

@interface PKMeetingPluginCitrixData : PKObjectData {

 @private
  NSInteger meetingId_;
  NSString *info_;
  NSString *url_;
}

@property NSInteger meetingId;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *url;

@end
