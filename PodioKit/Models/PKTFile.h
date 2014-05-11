//
//  PKTFile.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTObject.h"
#import "PKTConstants.h"

@interface PKTFile : PKTObject

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

+ (void)uploadWithData:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mimeType completion:(void (^)(PKTFile *file, NSError *error))completion;

- (void)attachWithReferenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType completion:(PKTRequestCompletionBlock)completion;

@end
