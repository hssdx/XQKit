//
//  UIViewController+XQHud.h
//  xq
//
//  Created by xiongxunquan on 2017/5/17.
//  Copyright © 2017年 xunquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;

@interface UIViewController (XQHud)

- (UIView *)xqHudHost;
- (MBProgressHUD *)xqShowHud;
- (MBProgressHUD *)xqShowHubWithText:(NSString *)text;
- (void)xqHideHud;
- (void)xqHideHudDelay:(CGFloat)delay;

@end
