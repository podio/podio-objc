//
//  PKFileData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/2/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKFileData : PKObjectData

@property NSInteger fileId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *descr;
@property (nonatomic, copy) NSString *hostedBy;
@property (nonatomic, copy) NSString *hostedByHumanizedName;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, copy) NSString *thumbnailLink;
@property (nonatomic, copy) NSString *mimeType;
@property NSInteger size;

- (BOOL)isHostedByPodio;

@end
