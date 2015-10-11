//
//  DemoRootViewController.m
//  KCExplodeTabBar
//
//  Created by Kevin Yufei Chen on 10/7/15.
//  Copyright © 2015 Kev1nChen. All rights reserved.
//

#import "DemoRootViewController.h"

#import <KCExplodeTabBar/KCExplodeTabBarController.h>

@interface DemoViewController : UIViewController

- (id)initWithTitle:(NSString *)title;

@end

@implementation DemoViewController

- (id)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        self.navigationItem.title = title;
    }
    return self;
}

@end

@interface DemoRootViewController ()

@property (nonatomic, strong) KCExplodeTabBarController *explodeTabBarController;
@property (nonatomic, strong) UITabBarController *tabBarController;

@end

@implementation DemoRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    DemoViewController *firstViewController = [[DemoViewController alloc] initWithTitle:@"First"];
    DemoViewController *secondViewController = [[DemoViewController alloc] initWithTitle:@"Second (Default)"];
    DemoViewController *thirdViewController = [[DemoViewController alloc] initWithTitle:@"Third"];
    DemoViewController *fourthViewController = [[DemoViewController alloc] initWithTitle:@"Fourth"];
    firstViewController.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:0.2];
    secondViewController.view.backgroundColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.2];
    thirdViewController.view.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.2];
    fourthViewController.view.backgroundColor = [UIColor colorWithRed:0.667 green:0.667 blue:0.667 alpha:0.2];
    
    UINavigationController *firstNavigationController = [[UINavigationController alloc] initWithRootViewController:firstViewController];
    UINavigationController *secondNavigationController = [[UINavigationController alloc] initWithRootViewController:secondViewController];
    UINavigationController *thirdNavigationController = [[UINavigationController alloc] initWithRootViewController:thirdViewController];
    UINavigationController *fourthNavigationController = [[UINavigationController alloc] initWithRootViewController:fourthViewController];

    firstNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"First" image:[UIImage imageNamed:@"FirstTabBarImage"] selectedImage:nil borderWidth:1.0 borderColor:[UIColor redColor]];
    secondNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Second" image:[UIImage imageNamed:@"SecondTabBarImage"] selectedImage:nil borderWidth:1.0 borderColor:[UIColor greenColor]];
    thirdNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Third" image:[UIImage imageNamed:@"ThirdTabBarImage"] selectedImage:nil borderWidth:1.0 borderColor:[UIColor blueColor]];
    fourthNavigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Fourth" image:[UIImage imageNamed:@"FourthTabBarImage"] selectedImage:nil borderWidth:1.0 borderColor:nil];
    
    self.explodeTabBarController = [[KCExplodeTabBarController alloc] init];
    self.explodeTabBarController.titleHidden = NO;
    self.explodeTabBarController.defaultViewControllerIndex = 1;
    [self.explodeTabBarController setViewControllers:@[firstNavigationController, secondNavigationController, thirdNavigationController, fourthNavigationController]];
    
    [self.navigationController setViewControllers:@[self, self.explodeTabBarController] animated:NO];
    
}

@end
