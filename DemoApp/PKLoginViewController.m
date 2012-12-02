//
//  PKLoginViewController.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 4/18/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKLoginViewController.h"

@interface PKLoginViewController ()

@end

@implementation PKLoginViewController
@synthesize loginButton;
@synthesize emailTextField;
@synthesize passwordTextField;

- (id)init {
  self = [super initWithNibName:NSStringFromClass([self class]) bundle:nil];
  if (self) {
  }
  return self;
}

- (IBAction)loginButtonPressed {
  NSString *email = self.emailTextField.text;
  NSString *password = self.passwordTextField.text;
  
  if ([email length] > 0 && [password length] > 0) {
    [[PKAPIClient sharedClient] authenticateWithEmail:email password:password completion:nil];
  }
}

- (void)viewDidUnload {
  self.loginButton = nil;
  self.emailTextField = nil;
  self.passwordTextField = nil;
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
