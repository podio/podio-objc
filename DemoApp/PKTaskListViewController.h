//
//  PKTaskListViewController.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 4/6/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKTaskListViewController : UITableViewController

@property (nonatomic) NSUInteger userId;

- (void)refreshTasks;

@end
