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
//  UIButton+XQUtils.m
//  XQKit
//
//  Created by quanxiong on 2017/8/24.
//  Copyright © 2017年 xun.quan. All rights reserved.
//

#import "UIButton+XQUtils.h"
#import <YYKit/YYKit.h>

static const char *s_origin_title;
static const char *s_timer;
static const char *s_count_down;

@implementation UIButton (XQUtils)

- (void)setXqCountDown:(CGFloat)xqCountDown {
    [self setAssociateValue:@(xqCountDown) withKey:&s_count_down];
}

- (CGFloat)xqCountDown {
    return [[self getAssociatedValueForKey:&s_count_down] floatValue];
}

- (void)setXqTimer:(NSTimer *)xqTimer {
    [self setAssociateValue:xqTimer withKey:&s_timer];
}

- (NSTimer *)xqTimer {
    return [self getAssociatedValueForKey:&s_timer];
}

- (void)setXqOriginTitle:(NSString *)xqOriginTitle {
    [self setAssociateValue:[xqOriginTitle copy] withKey:&s_origin_title];
}

- (NSString *)xqOriginTitle {
    return [self getAssociatedValueForKey:&s_origin_title];
}

- (void)xq_setEnable {
    self.enabled = YES;
    self.xqCountDown = 0;
    [self.xqTimer invalidate];
    self.xqTimer = nil;
    [self xq_setTitleRightNow:self.xqOriginTitle];
}

- (void)xq_setEnableIfNoCountDown:(BOOL)enable {
    if (self.xqTimer && !self.enabled) {
        //倒计时期间不设为 enable
        return;
    }
    if (self.xqOriginTitle == nil) {
        self.xqOriginTitle = self.titleLabel.text;
    }
    if (enable) {
        [self xq_setEnable];
    } else {
        self.enabled = NO;
    }
}

- (void)xq_setDisableWithPressBlock:(void(^)(UIButton *button))block
                          countDown:(CGFloat)countDown {
    @weakify(self);
    [self setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        @strongify(self);
        if (self.enabled == NO) {
            return;
        }
        //可重入
        self.enabled = NO;
        
        [self.xqTimer invalidate];
        self.xqCountDown = countDown;
        self.xqOriginTitle = self.titleLabel.text;
        
        @weakify(self);
        self.xqTimer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
            @strongify(self);
            self.xqCountDown -= 1;
            if (self.xqCountDown <= 0) {
                self.enabled = YES;
                [self xq_setTitleRightNow:self.xqOriginTitle];
                [self.xqTimer invalidate];
                s_timer = nil;
            } else {
                NSString *title = [NSString stringWithFormat:@"%@s", @(self.xqCountDown)];
                [self xq_setTitleRightNow:title];
            }
        } repeats:YES];
        [self.xqTimer fire];
        
        if (block) {
            block(self);
        }
    }];
}

- (void)xq_setTitleRightNow:(NSString *)title {
    self.titleLabel.text = title;
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)xq_applyDisableBackgroundColor {
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]]
                    forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor]
               forState:UIControlStateDisabled];
}

- (void)xq_setBackgroundColor:(UIColor *)color state:(UIControlState)state {
    [self setBackgroundImage:[UIImage imageWithColor:color]
                    forState:state];
}

- (void)xq_set2StateBackgroundColor:(UIColor *)color {
    self.reversesTitleShadowWhenHighlighted = YES;
    [self setBackgroundImage:[UIImage imageWithColor:color]
                    forState:UIControlStateNormal];
}

- (void)setXqDisableTitle:(NSString *)title {
    [self setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]]
                    forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor]
               forState:UIControlStateDisabled];
    [self setTitle:title forState:UIControlStateDisabled];
}

@end
