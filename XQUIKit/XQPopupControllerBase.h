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
//  XQPopupControllerBase.h
//  xunquan_kit
//
//  Created by xiongxunquan on 16/10/11.
//  Copyright © 2016年 xunquan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XQPopupStyle) {
    XQPopupStyleCenter,
    XQPopupStyleTop,
    XQPopupStyleLeft,
    XQPopupStyleBottom,
    XQPopupStyleRight,
    XQPopupStyleLeftTop,
    XQPopupStyleLeftBottom,
    XQPopupStyleRightBottom,
    XQPopupStyleRightTop,
};

typedef NS_ENUM(NSInteger, XQPopupAnimation) {
    XQPopupAnimationCenter,
    XQPopupAnimationTop,
    XQPopupAnimationLeft,
    XQPopupAnimationBottom,
    XQPopupAnimationRight,
};

typedef NS_ENUM(NSInteger, XQPopupCoreSize) {
    XQPopupCoreSizeEqualScreen,
    XQPopupCoreSizeLessScreen,
};

@class XQPopupControllerBase;

@protocol XQPopupControllerDelegate <NSObject>

- (void)controllerWillPopup:(XQPopupControllerBase *)controller;
- (void)controllerDidPopup:(XQPopupControllerBase *)controller;
- (void)controllerWillExit:(XQPopupControllerBase *)controller;
- (void)controllerDidExit:(XQPopupControllerBase *)controller;

@end

@interface XQPopupControllerBase : UIViewController

@property (strong, nonatomic, readonly) UIView *coreView;
@property (assign, nonatomic, readonly) BOOL onbusy;
@property (weak, nonatomic) id<XQPopupControllerDelegate> delegate;

//宽度，默认等于屏幕宽度，当 coreViewWidth 小于 1 时，取屏幕宽度
//不会超过屏幕宽度
@property (assign, nonatomic) CGFloat coreViewWidth;
//高度，默认 150
//不会超过屏幕高度
@property (assign, nonatomic) CGFloat coreViewHeight;
//布局样式
@property (assign, nonatomic) XQPopupStyle style;
@property (assign, nonatomic) XQPopupAnimation animationType;

#pragma mark - override
- (void)setupSubViews __attribute__((objc_requires_super));
- (void)configSubviews __attribute__((objc_requires_super));
- (void)makeConstraint __attribute__((objc_requires_super));

- (void)animatedExit;

@end
