//
//  PKStreamStatusData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"
#import "PKEmbedData.h"
#import "PKQuestionData.h"

@interface PKStreamStatusData : PKObjectData {

 @private
  NSInteger statusId_;
  NSString *value_;
  NSString *richValue_;
  PKEmbedData *embed_;
  PKQuestionData *question_;
}

@property (nonatomic) NSInteger statusId;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *richValue;
@property (nonatomic, strong) PKEmbedData *embed;
@property (nonatomic, strong) PKQuestionData *question;

@end
