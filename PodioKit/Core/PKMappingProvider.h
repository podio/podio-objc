//
//  PKMappingProvider.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Class used to by PKObjectMapper to lookup the corresponding domain object class name for a object mapping class name.
 */
@interface PKMappingProvider : NSObject {

 @private
  NSMutableDictionary *classMap_;
  NSMutableDictionary *inverseClassMap_;
}

- (void)addMappedClassName:(NSString *)mappedClassName forMappingClassName:(NSString *)mappingClassName;

- (Class)mappedClassForMappingClassName:(NSString *)mappingClassName;

- (Class)mappingClassForMappedClassName:(NSString *)mappedClassName;

- (void)buildClassMap;

@end
