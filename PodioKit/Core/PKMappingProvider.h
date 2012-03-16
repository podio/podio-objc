//
//  PKMappingProvider.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>

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
