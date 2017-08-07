//
//  UIViewController+XQHud.m
//  xq
//
//  Created by xiongxunquan on 2017/5/17.
//  Copyright © 2017年 xunquan. All rights reserved.
//

#import "UIViewController+XQHud.h"
#import <MBProgressHUD.h>

@implementation UIViewController (XQHud)

- (UIView *)xqHudHost {
    return [[UIApplication sharedApplication] keyWindow];
}

- (MBProgressHUD *)xqShowHud {
    return [self xqShowHubWithText:nil];
}

- (MBProgressHUD *)xqShowHubWithText:(NSString *)text {
    UIView *hudHost = [self xqHudHost];
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

- (void)xqHideHud {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:[self xqHudHost]];
    if (hud) {
        [hud hideAnimated:YES];
    }
}

- (void)xqHideHudDelay:(CGFloat)delay {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:[self xqHudHost]];
    if (hud) {
        [hud hideAnimated:YES afterDelay:delay];
    }
}

@end
