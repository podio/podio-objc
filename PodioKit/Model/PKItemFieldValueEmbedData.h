//
//  PKItemFieldValueEmbedData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/19/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKObjectData.h"


@interface PKItemFieldValueEmbedData : PKObjectData {

 @private
  NSInteger embedId_;
  NSString *type_;
  NSString *title_;
  NSString *descr_;
  NSString *resolvedURL_;
  NSString *originalURL_;
  
  NSInteger fileId_;
  NSString *fileLink_;
  NSString *fileMimeType_;
}

@property NSInteger embedId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *descr;
@property (nonatomic, copy) NSString *resolvedURL;
@property (nonatomic, copy) NSString *originalURL;

@property NSInteger fileId;
@property (nonatomic, copy) NSString *fileLink;
@property (nonatomic, copy) NSString *fileMimeType;

@end
