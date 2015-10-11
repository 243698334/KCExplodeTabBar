//
//  AppDelegate.m
//  KCExplodeTabBar
//
//  Created by Kev1nChen on 10/06/2015.
//  Copyright (c) 2015 Kev1nChen. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoRootViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[DemoRootViewController alloc] init]];
    navigationController.navigationBarHidden = YES;
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
