//
//  PKTFile+UIImage.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 25/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#if defined(__IPHONE_OS_VERSION_MIN_REQUIRED)

#import "PKTFile+UIImage.h"
#import "PKTFilesAPI.h"
#import "PKTMacros.h"

@implementation PKTFile (UIImage)

- (PKTAsyncTask *)downloadImage {
  NSParameterAssert(self.link);
  
  PKTRequest *request = [PKTFilesAPI requestToDownloadFileWithURL:self.link];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  PKTAsyncTask *task = [PKTAsyncTask taskForBlock:^PKTAsyncTaskCancelBlock(PKTAsyncTaskResolver *resolver) {
    
    [requestTask onSuccess:^(PKTResponse *response) {
      // Dispatch the loading of the image from NSData to a background thread for better performance
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        UIImage *image = [UIImage imageWithData:response.body];
        
        dispatch_async(dispatch_get_main_queue(), ^{
          [resolver succeedWithResult:image];
        });
      });
    } onError:^(NSError *error) {
      [resolver failWithError:error];
    }];
    
    PKT_WEAK(requestTask) weakTask = requestTask;
    
    return ^{
      [weakTask cancel];
    };
  }];
  
  return task;
}

@end

#endif