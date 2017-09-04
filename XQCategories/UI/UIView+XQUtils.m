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
//  UIView+XQUtils.m
//  XQ
//
//  Created by xiongxunquan on 2017/5/16.
//  Copyright © 2017年 xunquan. All rights reserved.
//

#import "UIView+XQUtils.h"
#import <YYKit/YYKit.h>

@implementation UIView (XQUtils)

- (void)xq_addTapAction:(void (^)(id sender))action {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes =
    [[UITapGestureRecognizer alloc] initWithActionBlock:action];
    [self addGestureRecognizer:tapGes];
}

- (void)xq_addTapAction:(void (^)(id sender))action withTimes:(NSInteger)times {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes =
    [[UITapGestureRecognizer alloc] initWithActionBlock:action];
    tapGes.numberOfTapsRequired = times;
    [self addGestureRecognizer:tapGes];
}

- (void)xq_addLongPressAction:(void (^)(id sender))action {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPressGes =
    [[UILongPressGestureRecognizer alloc] initWithActionBlock:action];
    [self addGestureRecognizer:longPressGes];
}

- (void)xq_addPanAction:(void (^)(UIPanGestureRecognizer *gesture))action {
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer *panGes =
    [[UIPanGestureRecognizer alloc] initWithActionBlock:action];
    [self addGestureRecognizer:panGes];
}


- (CGFloat)xqCornerRadius {
    return self.layer.cornerRadius;
}

- (void)setXqCornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.masksToBounds = YES;
}

- (void)xq_shock {
    [self xq_shockWithComplete:nil];
}

- (void)xq_shockWithComplete:(void(^)())complete {
    static CGFloat s_swing = 24;
    static CGFloat s_duration = 0.5;
    
    self.transform = CGAffineTransformMakeTranslation(-s_swing, 0);
    CGColorRef originBorderColor = self.layer.borderColor;
    CGFloat originBorderWidth = self.layer.borderWidth;
    self.layer.borderColor = [UIColor redColor].CGColor;
    self.layer.borderWidth = 1;
    [UIView animateWithDuration:s_duration
                          delay:0
         usingSpringWithDamping:0.2
          initialSpringVelocity:((s_swing + s_swing) / s_duration)
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^
     {
         self.transform = CGAffineTransformIdentity;
     } completion:^(BOOL finished)
     {
         self.layer.borderColor = originBorderColor;
         self.layer.borderWidth = originBorderWidth;
         if (complete) {
             complete();
         }
     }];
}

- (BOOL)xq_hitTest:(CGPoint)point enlarge:(UIEdgeInsets)enlarge {
    if (self.hidden || self.alpha < 0.01) {
        return NO;
    }
    if (point.x >= self.left - enlarge.left &&
        point.x <= self.right + enlarge.right &&
        point.y >= self.top - enlarge.top &&
        point.y <= self.bottom + enlarge.bottom) {
        return YES;
    }
    return NO;
}

@end
