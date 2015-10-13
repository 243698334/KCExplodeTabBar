//
//  KCExplodeTabBar.m
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

#import "KCExplodeTabBar.h"

CGFloat const kKCExplodeTabBarMainTabRadius = 30.0;
CGFloat const kKCExplodeTabBarTabRadius = 30.0;
CGFloat const kKCExplodeTabBarTabExpandRadius = 100.0;
CGFloat const kKCExplodeTabBarMainTabPadding = 10.0;

typedef NS_ENUM(NSInteger, KCExplodeTabBarState) {
    KCExplodeTabBarStateExpanded,
    KCExplodeTabBarStateCollapsed,
    KCExplodeTabBarStateAnimating
};

@interface KCExplodeTabBar ()

@property (nonatomic, assign) KCExplodeTabBarState tabBarState;

@property (nonatomic, strong) NSMutableArray *tabViews;
@property (nonatomic, strong) UIButton *mainTabButton;

@property (nonatomic, assign) NSInteger selectedTabIndex;

@end

@implementation KCExplodeTabBar

+ (CGRect)collapsedFrame {
    CGFloat width = kKCExplodeTabBarMainTabRadius * 2;
    CGFloat height = kKCExplodeTabBarMainTabRadius * 2 + kKCExplodeTabBarMainTabPadding;
    return CGRectMake([UIScreen mainScreen].applicationFrame.origin.x + ([UIScreen mainScreen].applicationFrame.size.width - width) / 2,
                      [UIScreen mainScreen].applicationFrame.size.height + 20 - height,
                      width,
                      height);
}

+ (CGRect)expandedFrame {
    CGFloat width = kKCExplodeTabBarTabExpandRadius * 2 + kKCExplodeTabBarTabRadius * 2;
    CGFloat height = kKCExplodeTabBarMainTabPadding + kKCExplodeTabBarMainTabRadius + kKCExplodeTabBarTabExpandRadius + kKCExplodeTabBarTabRadius;
    return CGRectMake([UIScreen mainScreen].applicationFrame.origin.x + ([UIScreen mainScreen].applicationFrame.size.width - width) / 2,
                      [UIScreen mainScreen].applicationFrame.size.height + 20 - height,
                      width,
                      height);
}

- (id)init {
    if (self = [super initWithFrame:[KCExplodeTabBar collapsedFrame]]) {
        self.tabBarState = KCExplodeTabBarStateCollapsed;
        self.tabViews = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.tabBarState = KCExplodeTabBarStateCollapsed;
        self.tabViews = [[NSMutableArray alloc] init];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    [self renderMainTab];
    [self renderTabs];
}

- (void)renderMainTab {
    NSInteger indexForDefaultTab = 0;
    if (self.dataSource != nil && [self.dataSource respondsToSelector:@selector(indexForDefaultTabInExplodeTabBar:)]) {
        indexForDefaultTab = [self.dataSource indexForDefaultTabInExplodeTabBar:self];
    }
    
    self.mainTabButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kKCExplodeTabBarMainTabRadius * 2, kKCExplodeTabBarMainTabRadius * 2)];
    self.mainTabButton.center = CGPointMake(self.bounds.size.width / 2, self.bounds.origin.y + self.bounds.size.height - kKCExplodeTabBarMainTabRadius - kKCExplodeTabBarMainTabPadding);
    self.mainTabButton.layer.masksToBounds = YES;
    self.mainTabButton.layer.cornerRadius = kKCExplodeTabBarMainTabRadius;
    if (self.dataSource != nil && [self.dataSource respondsToSelector:@selector(explodeTabBar:borderColorForTabAtIndex:)]) {
        NSInteger defaultTabIndex = 0;
        if ([self.dataSource respondsToSelector:@selector(indexForDefaultTabInExplodeTabBar:)]) {
            defaultTabIndex = [self.dataSource indexForDefaultTabInExplodeTabBar:self];
        }
        if ([self.dataSource explodeTabBar:self borderColorForTabAtIndex:defaultTabIndex] != nil) {
            self.mainTabButton.layer.borderColor = [self.dataSource explodeTabBar:self borderColorForTabAtIndex:defaultTabIndex].CGColor;
        } else {
            self.mainTabButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        }
    } else {
        self.mainTabButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    if (self.dataSource != nil && [self.dataSource respondsToSelector:@selector(borderWidthForMainTabInExplodeTabBar:)]) {
        self.mainTabButton.layer.borderWidth = [self.dataSource borderWidthForMainTabInExplodeTabBar:self];
    } else {
        self.mainTabButton.layer.borderWidth = 2.0;
    }
    [self.mainTabButton setImage:[self.dataSource explodeTabBar:self imageForTabAtIndex:indexForDefaultTab] forState:UIControlStateNormal];
    [self.mainTabButton addTarget:self action:@selector(didTapMainTabButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.mainTabButton];
}

- (void)renderTabs {
    if (self.dataSource != nil && [self.dataSource respondsToSelector:@selector(numberOfTabsInExplodeTabBar:)]) {
        for (NSInteger i = 0; i < [self.dataSource numberOfTabsInExplodeTabBar:self]; i++) {
            UIView *currentTabView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kKCExplodeTabBarTabRadius * 2, kKCExplodeTabBarTabRadius * 2 + 20)];
            currentTabView.tag = i;
            currentTabView.center = self.mainTabButton.center;
            
            UIButton *currentTabButton = [[UIButton alloc] initWithFrame:CGRectMake(currentTabView.bounds.origin.x, currentTabView.bounds.origin.y, currentTabView.bounds.size.width, kKCExplodeTabBarTabRadius * 2)];
            currentTabButton.tag = i;
            currentTabButton.layer.masksToBounds = YES;
            currentTabButton.layer.cornerRadius = kKCExplodeTabBarTabRadius;
            if ([self.dataSource respondsToSelector:@selector(explodeTabBar:borderColorForTabAtIndex:)] && [self.dataSource explodeTabBar:self borderColorForTabAtIndex:i] != nil) {
                currentTabButton.layer.borderColor = [self.dataSource explodeTabBar:self borderColorForTabAtIndex:i].CGColor;
            } else {
                currentTabButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
            }
            if ([self.dataSource respondsToSelector:@selector(explodeTabBar:borderWidthForTabAtIndex:)]) {
                currentTabButton.layer.borderWidth = [self.dataSource explodeTabBar:self borderWidthForTabAtIndex:i];
            } else {
                currentTabButton.layer.borderWidth = 1.0;
            }
            [currentTabButton setImage:[self.dataSource explodeTabBar:self imageForTabAtIndex:i] forState:UIControlStateNormal];
            [currentTabButton addTarget:self action:@selector(didTapTabButton:) forControlEvents:UIControlEventTouchUpInside];
            [currentTabView addSubview:currentTabButton];
            
            if ([self.dataSource respondsToSelector:@selector(explodeTabBar:titleForTabAtIndex:)]) {
                UILabel *currentTabTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(currentTabView.bounds.origin.x, currentTabView.bounds.origin.y + kKCExplodeTabBarTabRadius * 2, currentTabView.bounds.size.width, 20)];
                currentTabTitleLabel.textAlignment = NSTextAlignmentCenter;
                currentTabTitleLabel.text = [self.dataSource explodeTabBar:self titleForTabAtIndex:i];
                currentTabTitleLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
                [currentTabView addSubview:currentTabTitleLabel];
            }
            
            [self.tabViews addObject:currentTabView];
        }
    }
    
    if (self.dataSource != nil && [self.dataSource respondsToSelector:@selector(indexForDefaultTabInExplodeTabBar:)]) {
        self.selectedTabIndex = [self.dataSource indexForDefaultTabInExplodeTabBar:self];
    }
    
}

- (void)didTapTabButton:(UIButton *)tabButton {
    self.selectedTabIndex = tabButton.tag;
    [self collapseExplodeTabBarAnimated:YES];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(explodeTabBar:didSelectTabAtIndex:)]) {
        [self.delegate explodeTabBar:self didSelectTabAtIndex:tabButton.tag];
    }
}

- (void)didTapMainTabButton:(UIButton *)mainTabButton {
    if (self.dataSource != nil && [self.dataSource respondsToSelector:@selector(numberOfTabsInExplodeTabBar:)]) {
        if ([self.dataSource numberOfTabsInExplodeTabBar:self] > 1) {
            switch (self.tabBarState) {
                case KCExplodeTabBarStateCollapsed:
                    [self expandExplodeTabBarAnimated:YES];
                    break;
                case KCExplodeTabBarStateExpanded:
                    [self collapseExplodeTabBarAnimated:YES];
                    break;
                case KCExplodeTabBarStateAnimating:
                    break;
                default:
                    break;
            }
        }
    }
}

- (void)expandExplodeTabBarAnimated:(BOOL)animated {
    self.tabBarState = KCExplodeTabBarStateAnimating;

    self.frame = [KCExplodeTabBar expandedFrame];
    self.mainTabButton.center = CGPointMake(self.bounds.size.width / 2, self.bounds.origin.y + self.bounds.size.height - kKCExplodeTabBarMainTabRadius - kKCExplodeTabBarMainTabPadding);
    
    for (UIView *currentTabView in self.tabViews) {
        currentTabView.center = self.mainTabButton.center;
        [self insertSubview:currentTabView belowSubview:self.mainTabButton];
    }
    if (animated) {
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self expandExplodeTabBarAction];
        } completion:^(BOOL finished) {
            if (finished) {
                self.tabBarState = KCExplodeTabBarStateExpanded;
            }
        }];
    } else {
        [self expandExplodeTabBarAction];
        self.tabBarState = KCExplodeTabBarStateExpanded;
    }
}

- (void)expandExplodeTabBarAction {
    for (UIView *currentTabView in self.tabViews) {
        CGFloat radianBetweenTabs = M_PI / ([self.dataSource numberOfTabsInExplodeTabBar:self] - 1);
        CGFloat destinationCenterX = self.mainTabButton.center.x - cosf(currentTabView.tag * radianBetweenTabs) * kKCExplodeTabBarTabExpandRadius;
        CGFloat destinationCenterY = self.mainTabButton.center.y - sinf(currentTabView.tag * radianBetweenTabs) * kKCExplodeTabBarTabExpandRadius;
        currentTabView.center = CGPointMake(destinationCenterX, destinationCenterY);
        currentTabView.alpha = 1.0;
    }
}

- (void)collapseExplodeTabBarAnimated:(BOOL)animated {
    self.tabBarState = KCExplodeTabBarStateAnimating;

    if (animated) {
        [self bringSubviewToFront:[self.tabViews objectAtIndex:self.selectedTabIndex]];
        [UIView animateWithDuration:0.25 animations:^{
            for (UIView *currentTabView in self.tabViews) {
                currentTabView.center = CGPointMake(self.mainTabButton.center.x, self.mainTabButton.center.y + 10);
                if (currentTabView.tag != self.selectedTabIndex) {
                    currentTabView.alpha = 0.0;
                }
            }
            self.mainTabButton.imageView.alpha = 0.0;
        } completion:^(BOOL finished) {
            if (finished) {
                self.mainTabButton.imageView.alpha = 1.0;
                [self collapseExplodeTabBarAction];
            }
        }];
    } else {
        [self collapseExplodeTabBarAction];
    }
}

- (void)collapseExplodeTabBarAction {
    [self.mainTabButton setImage:[self.dataSource explodeTabBar:self imageForTabAtIndex:self.selectedTabIndex] forState:UIControlStateNormal];
    
    if ([self.dataSource respondsToSelector:@selector(explodeTabBar:borderColorForTabAtIndex:)] && [self.dataSource explodeTabBar:self borderColorForTabAtIndex:self.selectedTabIndex] != nil) {
        self.mainTabButton.layer.borderColor = [self.dataSource explodeTabBar:self borderColorForTabAtIndex:self.selectedTabIndex].CGColor;
    } else {
        self.mainTabButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }

    for (UIView *currentTabView in self.tabViews) {
        [currentTabView removeFromSuperview];
    }
    self.frame = [KCExplodeTabBar collapsedFrame];
    self.mainTabButton.center = CGPointMake(self.bounds.size.width / 2, self.bounds.origin.y + self.bounds.size.height - kKCExplodeTabBarMainTabRadius - kKCExplodeTabBarMainTabPadding);
    self.tabBarState = KCExplodeTabBarStateCollapsed;
}

@end
