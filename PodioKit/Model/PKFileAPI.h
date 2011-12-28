//
//  POFileAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/21/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKBaseAPI.h"
#import "PKFileOperation.h"
#import "PKRequestManager.h"

@interface PKFileAPI : PKBaseAPI

+ (PKFileOperation *)uploadFileWithPath:(NSString *)filePath fileName:(NSString *)fileName completion:(PKRequestCompletionBlock)completion;

+ (PKFileOperation *)uploadFileWithImage:(UIImage *)image completion:(PKRequestCompletionBlock)completion;

@end
