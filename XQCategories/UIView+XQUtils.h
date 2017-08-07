//
//  UIView+XQUtils.h
//  XQ
//
//  Created by xiongxunquan on 2017/5/16.
//  Copyright © 2017年 xunquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XQUtils)

- (void)addTapAction:(void (^)(id sender))action;
- (void)addTapAction:(void (^)(id sender))action withTimes:(NSInteger)times;
- (void)addLongPressAction:(void (^)(id sender))action;
- (void)addPanAction:(void (^)(UIPanGestureRecognizer *gesture))action;

@end
