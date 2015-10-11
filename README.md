# KCExplodeTabBar

[![Version](https://img.shields.io/cocoapods/v/KCExplodeTabBar.svg?style=flat)](http://cocoapods.org/pods/KCExplodeTabBar)
[![License](https://img.shields.io/cocoapods/l/KCExplodeTabBar.svg?style=flat)](http://cocoapods.org/pods/KCExplodeTabBar)
[![Platform](https://img.shields.io/cocoapods/p/KCExplodeTabBar.svg?style=flat)](http://cocoapods.org/pods/KCExplodeTabBar)

## Screenshots
![demo](https://cloud.githubusercontent.com/assets/5849363/10416041/686fe9fe-6fca-11e5-8ee5-0ccfdfac8c55.gif)
![screenshot](https://cloud.githubusercontent.com/assets/5849363/10415913/9b618c38-6fc4-11e5-84b2-aa93e36a8fa4.png)

## Documentation

Click [here](http://cocoadocs.org/docsets/KCExplodeTabBar) for full documentation. 

## Demo

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Usage

````objective-c
#import <KCExplodeTabBar/KCExplodeTabBarController.h>

self.explodeTabBarController = [[KCExplodeTabBarController alloc] init];
````

- **Style**

The title under each tab can be set hidden or not.
````objective-c
self.explodeTabBarController.titleHidden = NO;

````


You can customize the border width and the border color of each tab and the main tab. Use the `init` method in UITabBarItem’s category to create a `UITabBarItem` object with additional information and set it to your view controller.
````objective-c
UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Demo" 
                                                         image:[UIImage imageNamed:@"TabBarImage"] 
                                                 selectedImage:[UIImage imageNamed:@"SelectedTabBarImage"] 
                                                   borderWidth:1.0 
                                                   borderColor:[UIColor redColor]];
self.demoViewController.tabBarItem = tabBarItem;
````
There will be no border if you pass `0.0` to `borderWidth` or use the `UITabBarItem`'s default `init`.


- **Tabs**

The view controller displayed by `KCExplodeTabBar` by default does not have to be the first one. You can change it by changing the value of `defaultViewControllerIndex`.
````objective-c
self.explodeTabBarController.defaultViewControllerIndex = 1;

````


Add your view controllers just like a normal `UITabBarController`.
````objective-c
[self.explodeTabBarController setViewControllers:@[firstNavigationController, secondNavigationController, ...]];

````

Finally, display your `KCExplodeTabBar` just like you do with a normal `UITabBarController` (this depends on how you set up your navigation controller). See the demo for a possible way to do that. 
````objective-c
[self.navigationController setViewControllers:@[self, self.explodeTabBarController] animated:NO];

````

- **More Customization**

You can always implement your own tab bar controller by adopting `KCExplodeTabBarDataSource` and `KCExplodeTabBarDelegate`.
````objective-c
#import <KCExplodeTabBar/KCExplodeTabBar.h>
````


## Installation

KCExplodeTabBar is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

````ruby
pod "KCExplodeTabBar"
````

## Author

Kev1nChen (Kevin Yufei Chen)

## License

KCExplodeTabBar is available under the MIT license. See the LICENSE file for more info.
