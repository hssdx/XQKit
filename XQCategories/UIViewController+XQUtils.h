//
//  UIViewController+XQUtils.h
//  IKSarahah
//
//  Created by quanxiong on 2017/7/24.
//  Copyright © 2017年 com.xq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (XQUtils)

+ (instancetype)xq_controllerForNib;

- (void)xq_setupRightBarItemImage:(UIImage *)image selector:(SEL)selector;

- (void)xq_displayViewController:(UIViewController *)viewController;

- (void)xq_addChildViewControllerIfNeed:(UIViewController *)viewController;

- (void)xq_dismissSelf;

- (void)xq_safeExitSelf;

- (void)xq_setupRightSwipeToBack;

@end
