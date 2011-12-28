//
//  POTransformableImageData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKObjectData.h"


@interface PKItemFieldValueImageData : PKObjectData {

 @private
  NSInteger fileId_;
  NSString *link_;
  NSString *mimeType_;
  NSString *name_;
  NSInteger size_;
}

@property NSInteger fileId;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *mimeType;
@property (nonatomic, copy) NSString *name;
@property NSInteger size;

@end
