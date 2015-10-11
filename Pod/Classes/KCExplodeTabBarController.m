//
//  KCExplodeTabBarController.m
//  https://github.com/Kev1nChen/KCExplodeTabBar
//
//  Copyright (c) 2015 Kevin Yufei Chen
//
//  This code is distributed under the terms and conditions of the MIT license.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//


#import "KCExplodeTabBarController.h"

#import <objc/runtime.h>

@interface UITabBarItem (KCExplodeTabBarItemProperties)

@property (nonatomic, assign) CGFloat borderWidth;
@property (nonatomic, strong) UIColor *borderColor;

@end

@implementation UITabBarItem (KCExplodeTabBarItemProperties)

- (CGFloat)borderWidth {
    return [objc_getAssociatedObject(self, @selector(borderWidth)) floatValue];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    objc_setAssociatedObject(self, @selector(borderWidth), [NSNumber numberWithFloat:borderWidth], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)borderColor {
    return objc_getAssociatedObject(self, @selector(borderColor));
}

- (void)setBorderColor:(UIColor *)borderColor {
    objc_setAssociatedObject(self, @selector(borderColor), borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation UITabBarItem (KCExplodeTabBarItem)

- (id)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    if (self = [self initWithTitle:title image:image selectedImage:selectedImage]) {
        self.borderWidth = borderWidth;
        self.borderColor = borderColor;
    }
    return self;
}

@end

@interface KCExplodeTabBarController ()

@property (nonatomic, strong) KCExplodeTabBar *explodeTabBar;

@end

@implementation KCExplodeTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tabBar.hidden = YES;
    
    self.explodeTabBar = [[KCExplodeTabBar alloc] init];
    self.explodeTabBar.dataSource = self;
    self.explodeTabBar.delegate = self;
    [self.view addSubview:self.explodeTabBar];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(statusBarFrameWillChange:)
                                                 name:UIApplicationWillChangeStatusBarFrameNotification
                                               object:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [super setSelectedViewController:[self.viewControllers objectAtIndex:self.defaultViewControllerIndex]];
}

- (void)statusBarFrameWillChange:(NSNotification *)notification {
    CGFloat statusBarNewHeight = [[notification.userInfo objectForKey:UIApplicationStatusBarFrameUserInfoKey] CGRectValue].size.height;
    CGFloat statusBarCurrentHeight = statusBarNewHeight == 20.0 ? 40.0 : 20.0;
    CGRect explodeTabBarNewFrame = self.explodeTabBar.frame;
    explodeTabBarNewFrame.origin.y = explodeTabBarNewFrame.origin.y - (statusBarNewHeight - statusBarCurrentHeight);
    [UIView animateWithDuration:0.35 animations:^{
        self.explodeTabBar.frame = explodeTabBarNewFrame;
    }];
}


#pragma mark - KCExplodeTabBarDataSource

- (NSInteger)numberOfTabsInExplodeTabBar:(KCExplodeTabBar *)explodeTabBar {
    return self.viewControllers.count;
}

- (NSInteger)indexForDefaultTabInExplodeTabBar:(KCExplodeTabBar *)explodeTabBar {
    return self.defaultViewControllerIndex;
}

- (UIImage *)explodeTabBar:(KCExplodeTabBar *)explodeTabBar imageForTabAtIndex:(NSInteger)index {
    return [self.viewControllers objectAtIndex:index].tabBarItem.image;
}

- (UIImage *)explodeTabBar:(KCExplodeTabBar *)explodeTabBar selectedImageForTabAtIndex:(NSInteger)index {
    return [self.viewControllers objectAtIndex:index].tabBarItem.selectedImage;
}

- (NSString *)explodeTabBar:(KCExplodeTabBar *)explodeTabBar titleForTabAtIndex:(NSInteger)index {
    if (self.titleHidden) {
        return nil;
    } else {
        UIViewController *currentViewController = [self.viewControllers objectAtIndex:index];
        if (currentViewController.tabBarItem.title == nil) {
            if ([currentViewController isKindOfClass:[UINavigationController class]]) {
                return [((UINavigationController *)currentViewController).viewControllers objectAtIndex:0].navigationItem.title;
            } else {
                return currentViewController.navigationItem.title;
            }
        } else {
            return currentViewController.tabBarItem.title;
        }
    }
}

- (CGFloat)explodeTabBar:(KCExplodeTabBar *)explodeTabBar borderWidthForTabAtIndex:(NSInteger)index {
    return [self.viewControllers objectAtIndex:index].tabBarItem.borderWidth;
}

- (UIColor *)explodeTabBar:(KCExplodeTabBar *)explodeTabBar borderColorForTabAtIndex:(NSInteger)index {
    return [self.viewControllers objectAtIndex:index].tabBarItem.borderColor;
}


#pragma mark - KCExplodeTabBarDelegate

- (void)explodeTabBar:(KCExplodeTabBar *)explodeTabBar didSelectTabAtIndex:(NSInteger)index {
    [super setSelectedViewController:[self.viewControllers objectAtIndex:index]];
}



@end
