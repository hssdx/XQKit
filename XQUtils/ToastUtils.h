//
//  ToastUtils.h
//  vsfa
//
//  Created by long on 15/7/29.
//  Copyright © 2015年 long. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ToastLevel) {
    ToastLevelInfo,
    ToastLevelWarn,
    ToastLevelError,
};

#define ShowToast(format, ...) \
[ToastUtils show:format, ## __VA_ARGS__]

#define ShowWarnToast(format, ...) \
[ToastUtils showWarnning:format, ## __VA_ARGS__]

#define ShowErrorToast(format, ...) \
[ToastUtils showError:format, ## __VA_ARGS__]

#define MULTI_PARA_MSG(_MSG,_CONTENT) \
va_list args; \
va_start (args, _MSG); \
NSString *_CONTENT = [[NSString alloc] initWithFormat:_MSG arguments:args]; \
va_end (args);

@interface ToastUtils : NSObject

//显示提示视图, 默认显示在屏幕下方，2s后自动消失
+ (void)show:(NSString *)message, ... NS_FORMAT_FUNCTION(1,2);
+ (void)showWarnning:(NSString *)message, ... NS_FORMAT_FUNCTION(1,2);
+ (void)showError:(NSString *)message, ... NS_FORMAT_FUNCTION(1,2);

@end
