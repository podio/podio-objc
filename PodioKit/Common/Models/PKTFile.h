//
//  PKTFile.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"
#import "PKTClient.h"
#import "PKTConstants.h"

@interface PKTFile : PKTModel

@property (nonatomic, assign, readonly) NSUInteger fileID;
@property (nonatomic, assign, readonly) NSUInteger size;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *description;
@property (nonatomic, copy, readonly) NSString *mimeType;
@property (nonatomic, copy, readonly) NSString *hostedBy;
@property (nonatomic, copy, readonly) NSURL *link;
@property (nonatomic, copy, readonly) NSURL *thumbnailLink;
@property (nonatomic, copy, readonly) NSDate *createdOn;

#pragma mrk - API

+ (PKTRequestTaskHandle *)uploadWithData:(NSData *)data fileName:(NSString *)fileName completion:(void (^)(PKTFile *file, NSError *error))completion;

- (PKTRequestTaskHandle *)attachWithReferenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType completion:(PKTRequestCompletionBlock)completion;

- (PKTRequestTaskHandle *)downloadWithCompletion:(void (^)(NSData *data, NSError *error))completion;

- (PKTRequestTaskHandle *)downloadToFileWithPath:(NSString *)filePath completion:(void (^)(BOOL success, NSError *error))completion;

@end
