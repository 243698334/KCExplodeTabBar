//
//  KCExplodeTabBar.h
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

@class KCExplodeTabBar;

/**
 @abstract The methods of this protocol allow the data source to provide quantity, 
 images, titles, border widths, and border colors for the tabs. Also, the default 
 view controller displayed by the tab bar controller.
 */
@protocol KCExplodeTabBarDataSource <NSObject>

@required
/**
 @abstract Asks the data source for the number of tabs to be shown in the explode
 tab bar.
 @discussion It is suggested to return the number of view controllers.
 @param explodeTabBar An explode tab bar object requesting this information.
 @return The number of tabs in the explode tab bar.
 */
- (NSInteger)numberOfTabsInExplodeTabBar:(KCExplodeTabBar *)explodeTabBar;

@required
/**
 @abstract Asks the data source for an image to display in a particular tab.
 @param explodeTabBar An explode tab bar object requesting this information.
 @param index An index locating the tab.
 @return A image object to be displayed in the tab.
 */
- (UIImage *)explodeTabBar:(KCExplodeTabBar *)explodeTabBar imageForTabAtIndex:(NSInteger)index;

@optional
/**
 @abstract Asks the data source for an image to display in a particular tab 
 when the tab is currently being selected. This image will also displayed in
 the main tab.
 @discussion If not provided, the normal image will be used.
 @param explodeTabBar An explode tab bar object requesting this information.
 @param index An index locating the tab.
 @return A image object to be displayed in the tab when selected.
 */
- (UIImage *)explodeTabBar:(KCExplodeTabBar *)explodeTabBar selectedImageForTabAtIndex:(NSInteger)index;

@optional
/**
 @abstract Asks the data source for the index of the default view controller to be
 displayed initially.
 @param explodeTabBar An explode tab bar object requesting this information.
 @return An integer as the index of the default view controller.
 */
- (NSInteger)indexForDefaultTabInExplodeTabBar:(KCExplodeTabBar *)explodeTabBar;

@optional
/**
 @abstract Asks the data source for the title for each tab.
 @param explodeTabBar An explode tab bar object requesting this information.
 @param index An index locating the tab.
 @return An integer as the index of the default view controller.
 */
- (NSString *)explodeTabBar:(KCExplodeTabBar *)explodeTabBar titleForTabAtIndex:(NSInteger)index;

@optional
/**
 @abstract Asks the data source for the width of the border for each tab.
 @discussion If not provided, the default value 1.0 will be used.
 @param explodeTabBar An explode tab bar object requesting this information.
 @param index An index locating the tab.
 @return An float as the width of the border.
 */
- (CGFloat)explodeTabBar:(KCExplodeTabBar *)explodeTabBar borderWidthForTabAtIndex:(NSInteger)index;

@optional
/**
 @abstract Asks the data source for the color of the border for each tab.
 @discussion If not provided, the default value `[UIColor lightGrayColor]` will be
 used.
 @param explodeTabBar An explode tab bar object requesting this information.
 @param index An index locating the tab.
 @return A color displayed on the border of a tab.
 */
- (UIColor *)explodeTabBar:(KCExplodeTabBar *)explodeTabBar borderColorForTabAtIndex:(NSInteger)index;

@optional
/**
 @abstract Asks the data source for the width of the border for the main tab.
 @discussion If not provided, the default value 2.0 will be used.
 @param explodeTabBar An explode tab bar object requesting this information.
 @return An float as the width of border of the main tab.
 */
- (CGFloat)borderWidthForMainTabInExplodeTabBar:(KCExplodeTabBar *)explodeTabBar;

@end


/**
 @abstract The method of this protocol allow the delegate to manage selections of 
 tabs. The implementation of this should call `- (void)setSelectedViewController:`.
 */
@protocol KCExplodeTabBarDelegate <NSObject>

/**
 @abstract Tells the delegate that a tab was selected.
 @discussion Should call `- (void)setSelectedViewController:` to switch between
 view controllers.
 @param explodeTabBar An explode tab bar object informing the delegate.
 @param index The index of the selected tab.
 */
- (void)explodeTabBar:(KCExplodeTabBar *)explodeTabBar didSelectTabAtIndex:(NSInteger)index;

@end


@interface KCExplodeTabBar : UIView

/**
 @abstract The object that acts as the data source of the picker.
 */
@property (nonatomic, weak) id<KCExplodeTabBarDataSource> dataSource;

/**
 @abstract The object that acts as the delegate of the picker.
 */
@property (nonatomic, weak) id<KCExplodeTabBarDelegate> delegate;

@end
