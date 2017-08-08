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
//  XQLog.m
//  XQ
//
//  Created by xxq on 16/8/31.
//  Copyright © 2016年 xunquan. All rights reserved.
//

#import "XQLog.h"
#import "ToastUtils.h"
#import "XQUtilities.h"
#import <YYKit.h>

static BOOL s_hasCleaned = NO;

@implementation XQLog

+ (instancetype)logWithLevel:(XQLogLevel)level {
    XQLog *pushLog = [XQLog new];
    pushLog.time = @([[NSDate date] timeIntervalSince1970]);
    pushLog.level = @(level);
    pushLog.device = [UIDevice currentDevice].name;
    return pushLog;
}

+ (void)_showLogLevel:(XQLogLevel)level content:(NSString *)content {
#if DEBUG
    static NSDictionary *s_levelInfoDict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_levelInfoDict = @{@(XQLogLevelVerbose):@"[verbose]",
                            @(XQLogLevelDebug):@"[debug]",
                            @(XQLogLevelInfo):@"[info]",
                            @(XQLogLevelWarn):@"[warnning]",
                            @(XQLogLevelError):@"[error]"};
    });
    NSLog(@"%@%@", s_levelInfoDict[@(level)], content);
    if (level > XQLogLevelVerbose) {
        if (level == XQLogLevelWarn) {
            ShowWarnToast(@"%@%@", s_levelInfoDict[@(level)], content);
        }
        else if (level == XQLogLevelError) {
            ShowErrorToast(@"%@%@", s_levelInfoDict[@(level)], content);
        }
        else {
            ShowToast(@"%@%@", s_levelInfoDict[@(level)], content);
        }
    }
#endif
    
#if BUGLY
    static NSDictionary *s_XQLevelToBuglyLevel;
    static dispatch_once_t onceToken2;
    dispatch_once(&onceToken2, ^{
        s_XQLevelToBuglyLevel = @{@(XQLogLevelVerbose):@(BuglyLogLevelVerbose),
                                   @(XQLogLevelDebug):@(BuglyLogLevelDebug),
                                   @(XQLogLevelInfo):@(BuglyLogLevelInfo),
                                   @(XQLogLevelWarn):@(BuglyLogLevelWarn),
                                   @(XQLogLevelError):@(BuglyLogLevelError)};
    });
    
    NSNumber *buglyLevel = s_XQLevelToBuglyLevel[@(level)];
    [BuglyLog level:buglyLevel.unsignedIntegerValue log:@"%@", content];
#endif
}

+ (void)_logLevel:(XQLogLevel)level content:(NSString *)content {
    XQLog *pushLog = [XQLog logWithLevel:level];
    pushLog.content = content;
#if 0
    if ([XQLog tableExisted]) {
        [self cleanCache];
        [pushLog save];
    }
#endif
    [self _showLogLevel:level content:content];
}

+ (void)logLevel:(XQLogLevel)level content:(NSString *)fmt, ... {
    MULTI_PARA_MSG(fmt, content);
    [self _logLevel:level content:content];
}

+ (void)logLevel:(XQLogLevel)level dict:(NSDictionary *)dict {
    [self _logLevel:level content:[dict jsonPrettyStringEncoded]];
}

+ (void)logWithDict:(NSDictionary *)dict {
    [self logLevel:XQLogLevelDebug dict:dict];
}

+ (void)logVerbose:(NSString *)fmt, ... {
    MULTI_PARA_MSG(fmt, content);
    [self _logLevel:XQLogLevelVerbose content:content];
}

+ (void)logWarn:(NSString *)fmt, ... {
    MULTI_PARA_MSG(fmt, content);
    [self _logLevel:XQLogLevelWarn content:content];
}

+ (void)logError:(NSString *)fmt, ... {
    MULTI_PARA_MSG(fmt, content);
    [self _logLevel:XQLogLevelError content:content];
}

+ (void)cleanCache {
    if (s_hasCleaned) {
        //每次启动只清理一次
        return;
    }
    s_hasCleaned = YES;
}

@end



extern xq_force_inline void _XQAssertOutput(const char * szFunction,
                                             const char *szFile,
                                             int nLine,
                                             const char *szExpression)
{
    XQLog *pushLog = [XQLog logWithLevel:XQLogLevelError];
    pushLog.assertInfo =
    [NSString stringWithFormat:@"!断言: %s at %s %s:%d\n", szExpression, szFunction, szFile, nLine];
#if 0
    if ([XQLog tableExisted]) {
        [pushLog save];
    }
#endif
    [XQLog _showLogLevel:XQLogLevelError content:pushLog.assertInfo];
#if DEBUG
    NSLog(@"!出现断言，请务必认真对待【%@】", pushLog.assertInfo);
    xq_dispatch_main_async_safe(^{
        [NSThread sleepForTimeInterval:5];
    });
    //    kill(getpid(), SIGINT);
#endif
}
