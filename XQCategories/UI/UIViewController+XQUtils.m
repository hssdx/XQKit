/* 
MIT License

Copyright (c) 2017 xunquan

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 */
//
//  UIViewController+XQUtils.m
//  XQKit
//
//  Created by quanxiong on 2017/7/24.
//  Copyright © 2017年 com.xq. All rights reserved.
//

#import "UIViewController+XQUtils.h"
#import "UIColor+XQUtils.h"
#import "XQUtilities.h"
#import <YYKit/YYKit.h>

@implementation UIViewController (XQUtils)

+ (instancetype)xq_controllerForNib {
    return [[self alloc] initWithNibName:NSStringFromClass(self.class) bundle:[NSBundle mainBundle]];
}
- (void)xq_setupRightBarItemImage:(UIImage *)image
                            block:(void (^)(id sender))block {
    [self xq_setupRightBarItemImage:image tintColor:nil pressImage:nil block:block];
}

- (void)xq_setupRightBarItemImage:(UIImage *)image
                        tintColor:(UIColor *)tintColor
                       pressImage:(UIImage *)pressImage
                            block:(void (^)(id sender))block {
    if (!self.navigationController) {
        return;
    }
    if (!image) {
        return;
    }
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    if (tintColor) {
        button.tintColor = [UIColor lightTextColor];
    }
    if (pressImage) {
        [button setImage:pressImage forState:UIControlStateHighlighted];
    }
    button.frame = CGRectMake(0, 0, 20, 20);
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:block];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)xq_displayViewController:(UIViewController *)viewController {
    ASSERT_IS_MAIN_THREAD
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    viewController.view.frame = self.view.bounds;
    
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}

- (void)xq_addChildViewControllerIfNeed:(UIViewController *)viewController {
    ASSERT_IS_MAIN_THREAD
    if (![self.childViewControllers containsObject:viewController]) {
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
    }
}

- (void)xq_removeSelf {
    ASSERT_IS_MAIN_THREAD
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)xq_safePopSelf {
    ASSERT_IS_MAIN_THREAD
    if (self.navigationController) {
        if (self.navigationController.childViewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        } else if (self.navigationController.presentingViewController) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }
    } else if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)xq_safeDismissSelf {
    if (self.navigationController) {
        if (self.navigationController.presentingViewController) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        } else if (self.navigationController.childViewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    } else if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)xq_didSwipe:(UISwipeGestureRecognizer *)gesture {
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)xq_setupRightSwipeToBack {
    UISwipeGestureRecognizer *swipeGesture =
    [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(xq_didSwipe:)];
    [self.view addGestureRecognizer:swipeGesture];
}

- (void)xq_setBackBarItemNoTitle {
    if (!self.navigationController) {
        return;
    }
    self.navigationItem.backBarButtonItem =
    [[UIBarButtonItem alloc]initWithTitle:@""
                                    style:UIBarButtonItemStylePlain
                                   target:self
                                   action:nil];
}

@end
