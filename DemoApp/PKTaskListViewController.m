//
//  PKTaskListViewController.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 4/6/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKTaskListViewController.h"
#import "PKTaskAPI.h"
#import "PKDemoTask.h"
#import "PKDemoTaskMapping.h"

@interface PKTaskListViewController ()

@property (nonatomic, retain) NSArray *tasks;

@end

@implementation PKTaskListViewController

@synthesize userId = userId_;
@synthesize tasks = tasks_;

- (id)init {
  self = [super initWithStyle:UITableViewStylePlain];
  if (self) {
  }
  return self;
}

- (void)refreshTasks {
  PKAssert(self.userId > 0, @"User id must be greater than zero");
  
  // Get the first 40 tasks from the API
  PKRequest *request = [PKTaskAPI requestForMyTasksForUserId:self.userId offset:0 limit:0];
  
  // Attach an object mapping to use for the request
  request.objectMapping = [PKDemoTaskMapping mapping];
  request.mappingBlock = ^(id obj) {
    // Optional mapping block to modify/set values of the object not given by the response mapping
  };
  
  [request startWithCompletionBlock:^(NSError *error, PKRequestResult *result) {
    if (error == nil) {
      // Success
      self.tasks = result.resultData; // Result data contains the mapped objects
      [self.tableView reloadData];
    } else {
      // Failure
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Failed to load tasks." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
      [alert show];
    }
  }];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.title = @"My Tasks";
  
  self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
                                                                                         target:self 
                                                                                         action:@selector(refreshTasks)];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  
  self.tasks = nil;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  
  PKDemoTask *task = [self.tasks objectAtIndex:indexPath.row];
  cell.textLabel.text = task.text;
  
  return cell;
}

@end
