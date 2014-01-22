//
//  EXPMatchers+PKTBeSupersetOf.m
//  PodioKit
//
//  Created by Romain Briche on 22/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "EXPMatchers+PKTBeSupersetOf.h"

EXPMatcherImplementationBegin(pkt_beSupersetOf, (id subset)) {
  BOOL actualIsCompatible = [actual isKindOfClass:[NSDictionary class]] || [actual respondsToSelector:@selector(containsObject:)];
  BOOL subsetIsNil = (subset == nil);
  BOOL classMatches = [subset isKindOfClass:[actual class]];

  prerequisite(^BOOL{
    return actualIsCompatible && !subsetIsNil && classMatches;
  });

  match(^BOOL{
    if(!actualIsCompatible) return NO;

    if([actual isKindOfClass:[NSDictionary class]]) {
      for (id key in subset) {
        id actualValue = [actual valueForKey:key];
        id subsetValue = [subset valueForKey:key];

        if (![subsetValue isEqual:actualValue]) return NO;
      }
    } else {
      for (id object in subset) {
        if (![actual containsObject:object]) return NO;
      }
    }

    return YES;
  });

  failureMessageForTo(^NSString *{
    if(!actualIsCompatible) return [NSString stringWithFormat:@"%@ is not an instance of NSDictionary and does not implement -containsObject:", EXPDescribeObject(actual)];

    if(subsetIsNil) return @"the expected value is nil/null";

    if(!classMatches) return [NSString stringWithFormat:@"%@ does not match the class of %@", EXPDescribeObject(subset), EXPDescribeObject(actual)];

    return [NSString stringWithFormat:@"expected %@ to be a superset of %@", EXPDescribeObject(actual), EXPDescribeObject(subset)];
  });

  failureMessageForNotTo(^NSString *{
    if(!actualIsCompatible) return [NSString stringWithFormat:@"%@ is not an instance of NSDictionary and does not implement -containsObject:", EXPDescribeObject(actual)];

    if(subsetIsNil) return @"the expected value is nil/null";

    if(!classMatches) return [NSString stringWithFormat:@"%@ does not match the class of %@", EXPDescribeObject(subset), EXPDescribeObject(actual)];

    return [NSString stringWithFormat:@"expected %@ not to be a superset of %@", EXPDescribeObject(actual), EXPDescribeObject(subset)];
  });
}
EXPMatcherImplementationEnd
