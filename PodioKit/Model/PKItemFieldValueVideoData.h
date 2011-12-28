//
//  POTransformableVideoData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/19/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKObjectData.h"


@interface PKItemFieldValueVideoData : PKObjectData {

 @private
  NSInteger fileId_;
  NSString *descr_;
  NSString *link_;
  NSString *mimeType_;
  NSString *name_;
  NSInteger size_;
}

@property NSInteger fileId;
@property (nonatomic, copy) NSString *descr;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *mimeType;
@property (nonatomic, copy) NSString *name;
@property NSInteger size;

@end
