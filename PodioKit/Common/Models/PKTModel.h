//
//  PKTModel.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKTModel : NSObject <NSCoding, NSCopying>

/**
 *  Creates an instance with values from the provided dictionary, using the mapping dictionary returned
 *  from +dictionaryKeyPathsForPropertyNames.
 *
 *  @param dictionary A dictionary containing property values.
 *
 *  @return A new instance of the class, with values from the provided dictionary.
 */
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

/**
 *  Updates the instance with values from the provided dictionary.
 *
 *  @see -initWithDictionary:
 *
 *  @param dictionary A dictionary containing property values.
 */
- (void)updateFromDictionary:(NSDictionary *)dictionary;

/**
 *  Override this method in subclasses of PKTModel to define how to map the content of a dictionary
 *  provided through either the initWithDictionary: initializer or the updateFromDictionary: method.
 *  
 *  The general rules for mapping properties are:
 *  
 *  1. To map a dictionary key to a property, include the property name as the key of the returned dictionary,
 *     and the dictionary key path as the value of the dictionary.
 *  2. If the subclass has an ivar-backed property that matches the name of a dictionary key, it will be
 *     automatically mapped, so no need to explicitly include it in the returned dictionary.
 *  3. To transform a value (e.g. a NSString to an NSDate), implement a class method named '<property>ValueTransformer'
 *     or '<property>ValueTransformerWithDictionary:' that returns an instance of NSValueTransformer for the content.
 *
 *  @return A dictionary mapping the dictionary key paths to property names.
 */
+ (NSDictionary *)dictionaryKeyPathsForPropertyNames;

@end
