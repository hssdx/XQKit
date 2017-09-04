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
//  XQPopupControllerBase.m
//  xunquan_kit
//
//  Created by xiongxunquan on 16/10/11.
//  Copyright © 2016年 xunquan. All rights reserved.
//

#import "XQPopupControllerBase.h"
#import "XQUtilities.h"
#import "XQLog.h"
#import "UIViewController+XQUtils.h"
#import "UIView+XQUtils.h"
#import <YYKit/YYKit.h>
#import <Masonry/Masonry.h>

static CGFloat const kDuration = 0.3;

@interface XQPopupControllerBase ()
@property (strong, nonatomic) UIView *coreView;
@property (assign, nonatomic) BOOL onbusy;
@end

@implementation XQPopupControllerBase

- (UIColor *)transparentColor {
    return [UIColor colorWithWhite:0. alpha:0.01];
}

- (UIColor *)opaqueColor {
    return [UIColor colorWithWhite:0. alpha:0.6];
}

- (BOOL)isWidthEqualScreen {
    return fabs(self.coreViewWidth - XQPopupCoreSizeEqualScreen) < 0.0001;
}

- (BOOL)isWidthLessScreen {
    return fabs(self.coreViewWidth - XQPopupCoreSizeLessScreen) < 0.0001;
}

- (BOOL)isHeightEqualScreen {
    return fabs(self.coreViewHeight - XQPopupCoreSizeEqualScreen) < 0.0001;
}

- (BOOL)isHeightLessScreen {
    return fabs(self.coreViewHeight - XQPopupCoreSizeLessScreen) < 0.0001;
}

- (CGAffineTransform)beforeAnimateTransform {
    CGAffineTransform transform;
    switch (self.animationType) {
        case XQPopupAnimationCenter:
            transform = CGAffineTransformMakeScale(0.0001, 0.0001);
            break;
        case XQPopupAnimationTop:
            transform = CGAffineTransformMakeTranslation(0, -XQ_SCREEN_HEIGHT);
            break;
        case XQPopupAnimationLeft:
            transform = CGAffineTransformMakeTranslation(-XQ_SCREEN_WIDTH, 0);
            break;
        case XQPopupAnimationBottom:
            transform = CGAffineTransformMakeTranslation(0, XQ_SCREEN_HEIGHT);
            break;
        case XQPopupAnimationRight:
            transform = CGAffineTransformMakeTranslation(XQ_SCREEN_WIDTH, 0);
            break;
    }
    return transform;
}

- (void)configSubviews {
    self.view.backgroundColor = [self transparentColor];
    _coreView.transform = [self beforeAnimateTransform];
    _coreView.backgroundColor = [UIColor whiteColor];
    _coreView.layer.masksToBounds = YES;
    _coreView.layer.cornerRadius = 2;
    
    @weakify(self);
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        //@strongify(self);
        //do nothing for forbidden right-swipe gesture
        //[self animatedExit];
    }];
    [self.view addGestureRecognizer:panGesture];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        @strongify(self);
        [self animatedExit];
    }];
    [self.view addGestureRecognizer:tapGesture];
}

- (void)makeConstraint {
    [_coreView mas_makeConstraints:^(MASConstraintMaker *make) {
        switch (self.style) {
            case XQPopupStyleCenter:
                make.centerX.equalTo(self.view);
                make.centerY.equalTo(self.view);
                break;
            case XQPopupStyleTop:
                make.centerX.equalTo(self.view);
                make.top.equalTo(self.view);
                break;
            case XQPopupStyleLeft:
                make.left.equalTo(self.view);
                make.centerY.equalTo(self.view);
                break;
            case XQPopupStyleBottom:
                make.centerX.equalTo(self.view);
                make.bottom.equalTo(self.view);
                break;
            case XQPopupStyleRight:
                make.right.equalTo(self.view);
                make.centerY.equalTo(self.view);
                break;
            case XQPopupStyleLeftTop:
                make.left.equalTo(self.view);
                make.top.equalTo(self.view);
                break;
            case XQPopupStyleLeftBottom:
                make.left.equalTo(self.view);
                make.bottom.equalTo(self.view);
                break;
            case XQPopupStyleRightBottom:
                make.right.equalTo(self.view);
                make.bottom.equalTo(self.view);
                break;
            case XQPopupStyleRightTop:
                make.right.equalTo(self.view);
                make.top.equalTo(self.view);
                break;
        }
        if ([self isWidthLessScreen]) {
            make.width.equalTo(self.view).offset(-60);
        } else if ([self isWidthEqualScreen]) {
            make.width.equalTo(self.view);
        } else {
            make.width.equalTo(@(self.coreViewWidth));
        }
        if ([self isHeightLessScreen]) {
            make.height.equalTo(self.view).offset(-60);
        } else if ([self isHeightEqualScreen]) {
            make.height.equalTo(self.view);
        } else {
            make.height.equalTo(@(self.coreViewHeight));
        }
    }];
}

- (void)setupSubViews {
    _coreView = [UIView new];
    
    [self.view addSubview:_coreView];
}

- (void)_exitWithDuration:(CGFloat)duration complete:(void (^)(void))complete {
    if (self.onbusy) {
        return;
    }
    self.onbusy = YES;
    [self.delegate controllerWillExit:self];
    [UIView animateWithDuration:duration animations:^{
        self.coreView.transform = [self beforeAnimateTransform];
        self.view.backgroundColor = [self transparentColor];;
    } completion:^(BOOL finished) {
        [self xq_removeSelf];
        [self.delegate controllerDidExit:self];
        if (complete) {
            complete();
        }
        self.onbusy = NO;
    }];
}

- (void)animatedExit {
    [self _exitWithDuration:kDuration complete:nil];
}

- (void)_animatedShow {
    if (self.onbusy) {
        return;
    }
    self.onbusy = YES;
    
    @weakify(self);
    
    xq_dispatch_main_sync_safe(^{
        [self.delegate controllerWillPopup:self];
        
        if (self.animationType == XQPopupAnimationCenter) {
            [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                @strongify(self);
                self.coreView.transform = CGAffineTransformIdentity;
                self.view.backgroundColor = [self opaqueColor];
            } completion:^(BOOL finished) {
                @strongify(self);
                [self.delegate controllerDidPopup:self];
                self.onbusy = NO;
            }];
        } else {
            [UIView animateWithDuration:kDuration animations:^{
                @strongify(self);
                self.coreView.transform = CGAffineTransformIdentity;
                self.view.backgroundColor = [self opaqueColor];
            } completion:^(BOOL finished) {
                [self.delegate controllerDidPopup:self];
                self.onbusy = NO;
            }];
        }
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSubViews];
    [self configSubviews];
    [self makeConstraint];
    
    xq_dispatch_main_async_safe(^{
        [self performSelector:@selector(_animatedShow) withObject:nil afterDelay:0.01];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
