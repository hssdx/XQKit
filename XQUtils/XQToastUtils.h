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
//  XQToastUtils.h
//  vsfa
//
//  Created by xq on 15/7/29.
//  Copyright © 2015年 xq. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ToastLevel) {
    ToastLevelInfo,
    ToastLevelWarn,
    ToastLevelError,
};

#define ShowToastDelay(DELAY, FORMAT, ...) \
[XQToastUtils showDelay:DELAY message:FORMAT, ## __VA_ARGS__]

#define ShowWarnDelay(DELAY, FORMAT, ...) \
[XQToastUtils showWarnDelay:DELAY message:FORMAT, ## __VA_ARGS__]

#define ShowErrorDelay(DELAY, FORMAT, ...) \
[XQToastUtils showErrorDelay:DELAY message:FORMAT, ## __VA_ARGS__]


#define ShowToast(FORMAT, ...) \
[XQToastUtils show:FORMAT, ## __VA_ARGS__]

#define ShowWarnToast(FORMAT, ...) \
[XQToastUtils showWarn:FORMAT, ## __VA_ARGS__]

#define ShowErrorToast(FORMAT, ...) \
[XQToastUtils showError:FORMAT, ## __VA_ARGS__]

#define MULTI_PARA_MSG(_MSG,_CONTENT) \
va_list args; \
va_start (args, _MSG); \
NSString *_CONTENT = [[NSString alloc] initWithFormat:_MSG arguments:args]; \
va_end (args);

@interface XQToastUtils : NSObject

//显示提示视图, 默认显示在屏幕下方，2s后自动消失
+ (void)show:(NSString *)message, ... NS_FORMAT_FUNCTION(1,2);
+ (void)showWarn:(NSString *)message, ... NS_FORMAT_FUNCTION(1,2);
+ (void)showError:(NSString *)message, ... NS_FORMAT_FUNCTION(1,2);

+ (void)showDelay:(CGFloat)delay message:(NSString *)message, ... NS_FORMAT_FUNCTION(2,3);
+ (void)showWarnDelay:(CGFloat)delay message:(NSString *)message, ...NS_FORMAT_FUNCTION(2,3);
+ (void)showErrorDelay:(CGFloat)delay message:(NSString *)message, ... NS_FORMAT_FUNCTION(2,3);

@end
