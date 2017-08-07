//
//  UIViewController+XQUtils.m
//  IKSarahah
//
//  Created by quanxiong on 2017/7/24.
//  Copyright © 2017年 com.inke. All rights reserved.
//

#import "UIViewController+XQUtils.h"
#import "UIColor+XQUtils.h"

@implementation UIViewController (XQUtils)

+ (instancetype)xq_controllerForNib {
    return [[self alloc] initWithNibName:NSStringFromClass(self.class) bundle:[NSBundle mainBundle]];
}

- (void)xq_setupRightBarItemImage:(UIImage *)image
                         selector:(SEL)selector {
    if (!self.navigationController) {
        return;
    }
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    button.tintColor = [UIColor xqThemeTextColor];
    //    [button setImage:pressImage forState:UIControlStateHighlighted];
    button.frame = CGRectMake(0, 0, 20, 20);
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)xq_displayViewController:(UIViewController *)viewController {
    //    ASSERT_IS_MAIN_THREAD
    viewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    viewController.view.frame = self.view.bounds;
    
    [self addChildViewController:viewController];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
}

- (void)xq_addChildViewControllerIfNeed:(UIViewController *)viewController {
    //    ASSERT_IS_MAIN_THREAD
    if (![self.childViewControllers containsObject:viewController]) {
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
    }
}

- (void)xq_dismissSelf {
    //    ASSERT_IS_MAIN_THREAD
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)xq_safeExitSelf {
    //    ASSERT_IS_MAIN_THREAD
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

@end
