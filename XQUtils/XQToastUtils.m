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
//  XQToastUtils.m
//  vsfa
//
//  Created by xq on 15/7/29.
//  Copyright © 2015年 xq. All rights reserved.
//

#import "XQToastUtils.h"
#import <YYKit/YYKit.h>

@implementation XQToastUtils

#pragma mark - 显示提示视图
+ (void)show:(NSString *)message, ... NS_FORMAT_FUNCTION(1,2)
{
    MULTI_PARA_MSG(message, content)
    [self _show:content showTime:2 level:ToastLevelInfo];
}

+ (void)showWarnning:(NSString *)message, ... NS_FORMAT_FUNCTION(1,2)
{
    MULTI_PARA_MSG(message, content)
    [self _show:content showTime:2 level:ToastLevelWarn];
}

+ (void)showError:(NSString *)message, ... NS_FORMAT_FUNCTION(1,2)
{
    MULTI_PARA_MSG(message, content)
    [self _show:content showTime:2 level:ToastLevelError];
}

static UIView *s_toastView = nil;
static UILabel *s_toastLabel = nil;
static BOOL s_toastShowed = NO;
static const CGFloat s_toastHeight = 90;
static const CGFloat s_contentHeight = 70;

+ (void)_show:(NSString *)message showTime:(float)showTime level:(ToastLevel)level
{
    if (![[NSThread currentThread] isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _show:message showTime:showTime level:level];
        });
        return;
    }
//    ASSERT_IS_MAIN_THREAD
    if (s_toastView == nil) {
        s_toastView = [UIView new];
        s_toastLabel = [UILabel new];
        
        [s_toastView addSubview:s_toastLabel];
        
        
        s_toastLabel.textColor = [UIColor whiteColor];
        s_toastLabel.font = [UIFont systemFontOfSize:17];
        s_toastLabel.textAlignment = NSTextAlignmentCenter;
        s_toastLabel.numberOfLines = 0;
        s_toastLabel.lineBreakMode = NSLineBreakByCharWrapping;
        s_toastLabel.frame = CGRectMake(8, s_toastHeight - s_contentHeight + 20,
                                        [UIScreen mainScreen].bounds.size.width - 16,
                                        s_contentHeight - 20);
        
        [[UIApplication sharedApplication].keyWindow addSubview:s_toastView];
    }
    if (s_toastView.superview != [UIApplication sharedApplication].keyWindow) {
        [s_toastView removeFromSuperview];
        [[UIApplication sharedApplication].keyWindow addSubview:s_toastView];
    }
    switch (level) {
        case ToastLevelWarn:
        {
            s_toastView.backgroundColor = UIColorHex(ffbe49);
        }
            break;
        case ToastLevelError:
        {
            s_toastView.backgroundColor = UIColorHex(ff504b);
        }
            break;
        case ToastLevelInfo:
        default:
        {
            s_toastView.backgroundColor = UIColorHex(4fb9f8);
        }
            break;
    }
    s_toastLabel.text = message;
    
    if (!s_toastShowed) {
        s_toastShowed = YES;
        s_toastView.frame = CGRectMake(0, -s_toastHeight,
                                       [UIScreen mainScreen].bounds.size.width,
                                       s_toastHeight);
        [[self sharedToast] _showToast];
        [[self sharedToast] performSelector:@selector(_dimissToast)
                                 withObject:nil
                                 afterDelay:showTime
                                    inModes:@[NSRunLoopCommonModes]];
    } else {
        [self cancelPreviousPerformRequestsWithTarget:[self sharedToast]
                                             selector:@selector(_dimissToast)
                                               object:nil];
        [[self sharedToast] performSelector:@selector(_dimissToast)
                                 withObject:nil
                                 afterDelay:showTime
                                    inModes:@[NSRunLoopCommonModes]];
    }
}

+ (instancetype)sharedToast {
    static id toast;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toast = [XQToastUtils new];
    });
    return toast;
}

- (void)_showToast {
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        s_toastView.frame = CGRectMake(0, -(s_toastHeight - s_contentHeight),
                                       [UIScreen mainScreen].bounds.size.width,
                                       s_toastHeight);
    } completion:^(BOOL finished) {
    }];
}

- (void)_dimissToast {
    [UIView animateWithDuration:0.3 animations:^{
        s_toastView.frame = CGRectMake(0, -s_toastHeight,
                                       [UIScreen mainScreen].bounds.size.width,
                                       s_toastHeight);
    } completion:^(BOOL finished) {
        s_toastShowed = NO;
    }];
}

//根据字符串长度获取对应的宽度或者高度
+ (CGFloat)stringText:(NSString *)text font:(CGFloat)font isHeightFixed:(BOOL)isHeightFixed fixedValue:(CGFloat)fixedValue
{
    CGSize size;
    if (isHeightFixed) {
        size = CGSizeMake(MAXFLOAT, fixedValue);
    } else {
        size = CGSizeMake(fixedValue, MAXFLOAT);
    }
    
    CGSize resultSize;
    //返回计算出的size
    resultSize = [text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:font]} context:nil].size;
    
    if (isHeightFixed) {
        return resultSize.width;
    } else {
        return resultSize.height;
    }
}

@end
