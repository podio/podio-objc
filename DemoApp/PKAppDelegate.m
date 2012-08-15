//
//  PKAppDelegate.m
//  DemoApp
//
//  Created by Sebastian Rehnby on 4/4/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKAppDelegate.h"
#import "PKLoginViewController.h"
#import "PKTaskListViewController.h"

// Provide a descriptive user agent to make it easier to track issues with your application in logs etc.
static NSString * const kUserAgent = @"PodioKit DemoApp/1.0";

@interface PKAppDelegate ()

@property (nonatomic, strong) PKOAuth2Token *authToken;
@property (nonatomic, strong) PKTaskListViewController *taskListController;

- (void)presentLoginScreenAnimated:(BOOL)animated;
- (void)logout;

// Session livecycle notifications
- (void)didAuthenticateUserNotification:(NSNotification *)notification;
- (void)authenticationDidFailNotification:(NSNotification *)notification;
- (void)needsReauthenticationNotification:(NSNotification *)notification;

@end

@implementation PKAppDelegate

@synthesize window = window_;
@synthesize authToken = authToken_;
@synthesize taskListController = taskListController_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {  
  // Configure PodioKit. Define your API client id and secret in the DemoApp-Configuration.plist file
  NSString *configPath = [[NSBundle mainBundle] pathForResource:@"DemoApp-Configuration" ofType:@"plist"];
  NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile:configPath];
  NSString *clientId = [config objectForKey:@"APIClientID"];
  NSString *clientSecret = [config objectForKey:@"APIClientSecret"];
  
  [[PKAPIClient sharedClient] configureWithClientId:clientId secret:clientSecret];
  [[PKAPIClient sharedClient] setUserAgent:kUserAgent];
  
  // A mapping provider is required to look up the domain object class for an object mapping used to map the 
  // response from the server. A provider contains the relationships between a mapping definition and a domain object class.
  // The relationship might eventually change to be domain object class => mapping class, as it makes more sense, 
  // but for now this is the current implementation.
  PKMappingProvider *provider = [[PKMappingProvider alloc] init];
  [provider addMappedClassName:@"PKDemoTask" forMappingClassName:@"PKDemoTaskMapping"];
  
  [PKRequestManager sharedManager].mappingCoordinator = [[PKDefaultMappingCoordinator alloc] initWithMappingProvider:provider];
  
  // Listen for session lifecycle events
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didAuthenticateUserNotification:) name:PKAPIClientDidAuthenticateUser object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(authenticationDidFailNotification:) name:PKAPIClientAuthenticationFailed object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needsReauthenticationNotification:) name:PKAPIClientNeedsReauthentication object:nil];
  
  // Initialize window
  self.taskListController = [[PKTaskListViewController alloc] init];
  self.taskListController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Log out", nil) style:UIBarButtonItemStyleBordered target:self action:@selector(logout)];
  
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.taskListController];
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = navController;
  [self.window makeKeyAndVisible];
  
  return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  if (self.authToken == nil) {
    [self presentLoginScreenAnimated:NO];
  }
}

#pragma mark - Implementation

- (void)presentLoginScreenAnimated:(BOOL)animated {
  PKLoginViewController *controller = [[PKLoginViewController alloc] init];
  [self.window.rootViewController presentViewController:controller animated:NO completion:nil];
}

- (void)logout {
  self.authToken = nil;
  [self presentLoginScreenAnimated:YES];
}

#pragma mark - Session lifecycle notifications

- (void)didAuthenticateUserNotification:(NSNotification *)notification {
  [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
  
  self.authToken = [notification.userInfo objectForKey:PKAPIClientTokenKey];
  self.taskListController.userId = [[self.authToken.refData pk_objectForKey:@"id"] unsignedIntegerValue];
  
  // Successful authentication, refresh tasks
  [self.taskListController refreshTasks];
}

- (void)authenticationDidFailNotification:(NSNotification *)notification {
  // Authentication failed, retry
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Authentication failed." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
  [alert show];
}

- (void)needsReauthenticationNotification:(NSNotification *)notification {
  // This means the existing token expired and cannot be refreshed. In a real application, you should prompt 
  // the user for their email/password again.
}

@end
