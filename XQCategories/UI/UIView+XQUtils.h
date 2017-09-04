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
//  UIView+XQUtils.h
//  XQ
//
//  Created by xiongxunquan on 2017/5/16.
//  Copyright © 2017年 xunquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XQUtils)

- (void)xq_addTapAction:(void (^)(id sender))action;
- (void)xq_addTapAction:(void (^)(id sender))action withTimes:(NSInteger)times;
- (void)xq_addLongPressAction:(void (^)(id sender))action;
- (void)xq_addPanAction:(void (^)(UIPanGestureRecognizer *gesture))action;

//for use kcv
- (CGFloat)xqCornerRadius;
- (void)setXqCornerRadius:(CGFloat)radius;

- (void)xq_shock;
- (void)xq_shockWithComplete:(void(^)())complete;

- (BOOL)xq_hitTest:(CGPoint)point enlarge:(UIEdgeInsets)enlarge;

@end
