//
//  KCExplodeTabBarController.h
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

#import <UIKit/UIKit.h>

#import "KCExplodeTabBar.h"

/**
 @abstract Add one more init method with border configurations for a tab.
 */
@interface UITabBarItem (KCExplodeTabBarItem)
/**
 @abstract Create an `UITabBarItem` with more attributes defined in this category.
 @param title A title for a tab.
 @param image An image to be displayed on a tab by default.
 @param selectedImage An image to be displayed when a tab is selected.
 @param borderWidth The width of the border on a tab.
 @param borderColor The color of the border on a tab.
 */
- (id)initWithTitle:(NSString *)title image:(UIImage *)image selectedImage:(UIImage *)selectedImage borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

@end

@interface KCExplodeTabBarController : UITabBarController<KCExplodeTabBarDataSource, KCExplodeTabBarDelegate>

/**
 @abstract Specifies if the titles under all tabs are hidden.
 */
@property (nonatomic, assign, getter=isTitleHidden) BOOL titleHidden;

/**
 @abstract Specifies the index of the view controller displayed by default.
 */
@property (nonatomic, assign) NSInteger defaultViewControllerIndex;

/**
 @abstract Specifies the border of the main tab.
 */
@property (nonatomic, assign) CGFloat mainTabBorderWidth;

@end
