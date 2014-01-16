//
//  PKReferenceMessageData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/7/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"
#import "PKEmbedData.h"
#import "PKFileData.h"

@interface PKReferenceMessageData : PKObjectData

@property (nonatomic) NSInteger messageId;
@property (nonatomic, copy) NSString *text;
@property (nonatomic) BOOL isReply;
@property (nonatomic, copy) NSArray *files;
@property (nonatomic, strong) PKEmbedData *embed;

@end
