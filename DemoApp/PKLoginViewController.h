//
//  PKLoginViewController.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 4/18/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PKLoginViewController : UIViewController

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *loginButton;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *emailTextField;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)loginButtonPressed;

@end
