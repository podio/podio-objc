//
//  POFileData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/2/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKObjectData.h"

@interface PKFileData : PKObjectData {

 @private
  NSInteger fileId_;
  NSString *name_;
  NSString *descr_;
  NSString *hostedBy_;
  NSString *link_;
  NSString *mimeType_;
  NSInteger size_;
}

@property NSInteger fileId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *descr;
@property (nonatomic, copy) NSString *hostedBy;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *mimeType;
@property NSInteger size;

@end
