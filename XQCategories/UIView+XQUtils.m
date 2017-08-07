//
//  UIView+XQUtils.m
//  XQ
//
//  Created by xiongxunquan on 2017/5/16.
//  Copyright © 2017年 xunquan. All rights reserved.
//

#import "UIView+XQUtils.h"
#import <YYKit.h>

@implementation UIView (XQUtils)

- (void)addTapAction:(void (^)(id sender))action {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes =
    [[UITapGestureRecognizer alloc] initWithActionBlock:action];
    [self addGestureRecognizer:tapGes];
}

- (void)addTapAction:(void (^)(id sender))action withTimes:(NSInteger)times {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes =
    [[UITapGestureRecognizer alloc] initWithActionBlock:action];
    tapGes.numberOfTapsRequired = times;
    [self addGestureRecognizer:tapGes];
}

- (void)addLongPressAction:(void (^)(id sender))action {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPressGes =
    [[UILongPressGestureRecognizer alloc] initWithActionBlock:action];
    [self addGestureRecognizer:longPressGes];
}

- (void)addPanAction:(void (^)(UIPanGestureRecognizer *gesture))action {
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer *panGes =
    [[UIPanGestureRecognizer alloc] initWithActionBlock:action];
    [self addGestureRecognizer:panGes];
}

@end
