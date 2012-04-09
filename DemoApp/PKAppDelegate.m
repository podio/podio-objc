//
//  PKAppDelegate.m
//  DemoApp
//
//  Created by Sebastian Rehnby on 4/4/12.
//  Copyright (c) 2012 Rehserve IT. All rights reserved.
//

#import "PKAppDelegate.h"
#import "PKTaskListViewController.h"

// Your API key/secret
static NSString * const kAPIKey = @"podiokit-demo-app";
static NSString * const kAPISecret = @"KmClI7RDBXPRTxtf9mjSbecJf9NMLtDjA45Hm5V0u63f7ebbRqIPGKcR0OdJRO6q";

// Provide a descriptive user agent to make it easier to track issues with your application in logs etc.
static NSString * const kUserAgent = @"PodioKit DemoApp/1.0";

// Your application should prompt the user for their credentials
static NSString * const kEmail = @"podiokitdemoapp@gmail.com";
static NSString * const kPassword = @"sup3rs3cr3t";

@interface PKAppDelegate ()

@property (nonatomic, strong) PKOAuth2Token *authToken;
@property (nonatomic, strong) PKTaskListViewController *taskListController;

// Session livecycle callbacks
- (void)didAuthenticateUserNotification:(NSNotification *)notification;
- (void)authenticationDidFailNotification:(NSNotification *)notification;
- (void)needsReauthenticationNotification:(NSNotification *)notification;

@end

@implementation PKAppDelegate

@synthesize window = window_;
@synthesize authToken = authToken_;
@synthesize taskListController = taskListController_;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {  
  // Configure PodioKit
  [[PKAPIClient sharedClient] configureWithClientId:kAPIKey secret:kAPISecret];
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
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.taskListController];
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = navController;
  [self.window makeKeyAndVisible];
  
  return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Authenticate whenever the application becomes active. Excessive in a real application but simple for the demo.
  [[PKAPIClient sharedClient] authenticateWithEmail:kEmail password:kPassword];
}

- (void)didAuthenticateUserNotification:(NSNotification *)notification {
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
