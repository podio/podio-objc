//
//  PKLoginViewController.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 4/18/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKLoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginButtonPressed;

@end
