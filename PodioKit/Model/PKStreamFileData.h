//
//  POStreamFileData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/21/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKObjectData.h"

@interface PKStreamFileData : PKObjectData {

 @private
  NSInteger fileId_;
  NSString *name_;
  NSString *description_;
  NSString *mimeType_;
  NSInteger size_;
}

@property NSInteger fileId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *mimeType;
@property NSInteger size;

@end
