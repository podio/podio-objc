//
//  PKTItemRevision.h
//  PodioKit
//
//  Created by Romain Briche on 23/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

typedef NS_ENUM(NSInteger, PKTItemRevisionType) {
  PKTItemRevisionTypeUnknown = 0,
  PKTItemRevisionTypeCreation,
  PKTItemRevisionTypeUpdate,
  PKTItemRevisionTypeDelete
};

@interface PKTItemRevision : PKTModel

@property (nonatomic, assign, readonly) NSUInteger itemRevisionID;
@property (nonatomic, assign, readonly) PKTItemRevisionType type;
@property (nonatomic, assign, readonly) NSUInteger revision;

@end
