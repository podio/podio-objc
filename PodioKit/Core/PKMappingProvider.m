//
//  PKMappingProvider.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKMappingProvider.h"

@interface PKMappingProvider ()

@property (nonatomic, readonly) NSMutableDictionary *classMap;
@property (nonatomic, readonly) NSMutableDictionary *inverseClassMap;

@end

@implementation PKMappingProvider

@synthesize classMap = classMap_;
@synthesize inverseClassMap = inverseClassMap_;

- (id)init {
  self = [super init];
  if (self) {
    classMap_ = [[NSMutableDictionary alloc] init];
    inverseClassMap_ = [[NSMutableDictionary alloc] init];
    
    [self buildClassMap];
  }
  
  return self;
}


- (void)addMappedClassName:(NSString *)mappedClassName forMappingClassName:(NSString *)mappingClassName {
  PKAssert(mappedClassName != nil, @"Mapped class cannot be nil");
  PKAssert(mappingClassName != nil, @"Mapping class cannot be nil");
  [self.classMap setObject:mappedClassName forKey:mappingClassName];
  [self.inverseClassMap setObject:mappingClassName forKey:mappedClassName];  
}

- (Class)mappedClassForMappingClassName:(NSString *)mappingClassName {
  PKAssert(mappingClassName != nil, @"Mapping class cannot be nil");
  NSString *className = [self.classMap objectForKey:mappingClassName];
  Class klass = NSClassFromString(className);
  
  return klass;
}

- (Class)mappingClassForMappedClassName:(NSString *)mappedClassName {
  PKAssert(mappedClassName != nil, @"Mapping class cannot be nil");
  NSString *className = [self.inverseClassMap objectForKey:mappedClassName];
  Class klass = NSClassFromString(className);
  
  if (klass == nil) {
    PKLogDebug(@"No mapping for class name %@", mappedClassName);
  }
  
  return klass;
}

- (void)buildClassMap {
  // Implement in subclass to register mappings
}

@end
