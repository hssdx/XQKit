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
//  UIViewController+XQHud.m
//  xq
//
//  Created by xiongxunquan on 2017/5/17.
//  Copyright © 2017年 xunquan. All rights reserved.
//

#import "UIViewController+XQHud.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation UIViewController (XQHud)

- (UIView *)xq_hudHost {
    return [[UIApplication sharedApplication] keyWindow];
}

- (MBProgressHUD *)xq_showHud {
    return [self xq_showHudWithText:nil];
}

- (MBProgressHUD *)xq_showHudWithText:(NSString *)text {
    UIView *hudHost = [self xq_hudHost];
    MBProgressHUD *hud = [MBProgressHUD HUDForView:hudHost];
    if (hud) {
        [hud showAnimated:YES];
    } else {
        hud = [MBProgressHUD showHUDAddedTo:hudHost animated:YES];
    }
    if (text) {
        hud.label.text = text;
    }
    return hud;
}

- (void)xq_hideHud {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:[self xq_hudHost]];
    if (hud) {
        [hud hideAnimated:YES];
    }
}

- (void)xq_hideHudDelay:(CGFloat)delay {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:[self xq_hudHost]];
    if (hud) {
        [hud hideAnimated:YES afterDelay:delay];
    }
}

@end
