//
//  PKExternalFileData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/28/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKObjectData.h"

@interface PKExternalFileData : PKObjectData

@property (nonatomic, copy) NSString *externalFileId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mimeType;
@property (nonatomic, copy) NSDate *createdOn;
@property (nonatomic, copy) NSDate *updatedOn;
@property (nonatomic) BOOL isFolder;

@end
