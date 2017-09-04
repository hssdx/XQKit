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
//  UIViewController+XQUtils.h
//  XQKit
//
//  Created by quanxiong on 2017/7/24.
//  Copyright © 2017年 com.xq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (XQUtils)

+ (instancetype)xq_controllerForNib;

- (void)xq_setupRightBarItemImage:(UIImage *)image block:(void (^)(id sender))block;
- (void)xq_setupRightBarItemImage:(UIImage *)image
                        tintColor:(UIColor *)tintColor
                       pressImage:(UIImage *)pressImage
                            block:(void (^)(id sender))block;

- (void)xq_displayViewController:(UIViewController *)viewController;

- (void)xq_addChildViewControllerIfNeed:(UIViewController *)viewController;

- (void)xq_removeSelf;

- (void)xq_safePopSelf;

- (void)xq_safeDismissSelf;

- (void)xq_setupRightSwipeToBack;

- (void)xq_setBackBarItemNoTitle;

@end
