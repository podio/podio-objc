//
//  PKLinkedAccountData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/29/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKObjectData.h"

@interface PKLinkedAccountData : PKObjectData

@property (nonatomic) NSInteger linkedAccountId;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *provider;
@property (nonatomic, copy) NSString *providerHumanizedName;

@end
