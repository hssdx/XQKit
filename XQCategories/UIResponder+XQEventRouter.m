//
//  UIResponder+XQEventRouter.m
//  IKSarahah
//
//  Created by quanxiong on 2017/8/3.
//  Copyright © 2017年 com.xq. All rights reserved.
//

#import "UIResponder+XQEventRouter.h"
#import "XQLog.h"

@implementation UIResponder (XQEventRouter)

- (void)routEvent:(NSString *)eventName {
    if (self.nextResponder) {
        [self.nextResponder routEvent:eventName info:nil sender:self];
    }
}

- (void)routEvent:(NSString *)eventName info:(NSDictionary *)info {
    if (self.nextResponder) {
        [self.nextResponder routEvent:eventName info:info sender:self];
    }
}

- (void)routEvent:(NSString *)eventName info:(NSDictionary *)info sender:(id)sender {
    if (eventName.length == 0) {
        XQAssert(eventName.length);
        return;
    }
    if (self.nextResponder) {
        [self.nextResponder routEvent:eventName info:info sender:sender];
    }
}

@end
