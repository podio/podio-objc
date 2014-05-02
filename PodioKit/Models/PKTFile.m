//
//  PKTFile.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTFile.h"
#import "PKTFileAPI.h"
#import "PKTResponse.h"

@implementation PKTFile

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"fileID" : @"file_id"
           };
}

#pragma mrk - API

+ (void)uploadWithImage:(PKTImage *)image fileName:(NSString *)fileName completion:(void (^)(PKTFile *file, NSError *error))completion {
  NSData *data = UIImageJPEGRepresentation(image, 0.8f);
  [self uploadWithData:data fileName:fileName mimeType:@"image/jpeg" completion:completion];
}

+ (void)uploadWithData:(NSData *)data fileName:(NSString *)fileName mimeType:(NSString *)mimeType completion:(void (^)(PKTFile *file, NSError *error))completion {
  PKTRequest *request = [PKTFileAPI requestToUploadFileWithData:data fileName:fileName mimeType:mimeType];
  
  [[self client] performRequest:request completion:^(PKTResponse *response, NSError *error) {
    PKTFile *file = nil;
    
    if (!error) {
      file = [[PKTFile alloc] initWithDictionary:response.body];
    }
    
    if (completion) completion(file, error);
  }];
}

@end
