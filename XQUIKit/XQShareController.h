//
//  XQShareController.h
//  IKSarahah
//
//  Created by quanxiong on 2017/7/30.
//  Copyright © 2017年 com.xq. All rights reserved.
//

#import "XQPopupControllerBase.h"

@interface WXShareAction : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) void(^handle)(UIView *action);

+ (instancetype)actionWithTitle:(NSString *)title
                           icon:(NSString *)icon
                         handle:(void(^)(UIView *action))handle;

@end



@interface XQShareController : XQPopupControllerBase

+ (instancetype)controllerWithTopic:(NSString *)topic;

- (void)addAction:(WXShareAction *)action;

@end
