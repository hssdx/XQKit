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
//  XQLog.h
//  XQ
//
//  Created by xxq on 16/8/31.
//  Copyright © 2016年 xunquan. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, XQLogLevel) {
    XQLogLevelVerbose,
    XQLogLevelDebug,
    XQLogLevelInfo,
    XQLogLevelWarn,
    XQLogLevelError,
};


extern void _XQAssertOutput(const char * szFunction, const char *szFile, int nLine, const char *szExpression);

#undef XQAssert

#if DEBUG //if

#define XQAssert(e) (!(e) ? _XQAssertOutput(__func__, __FILE__, __LINE__, #e) : (void)0)
#define XQLog(...) [XQLog logVerbose:__VA_ARGS__]
#define XQLogForFrame(frame)  [XQLog logVerbose:@"%s %s%@",__PRETTY_FUNCTION__,#frame,NSStringFromCGRect(frame)]

#define XQ_DEALLOC_IMP -(void)dealloc { XQLog(@"[dealloc]%s", __func__); }
#define XQ_ASSERT_RESULT(___) BOOL VA = (___); XQAssert(VA);

#define BUGLY 0

#else //else

#define XQAssert(e) (void)0
#define XQLog(...) (void)0
#define XQLogForFrame(frame) (void)0
#define XQ_DEALLOC_IMP 
#define XQ_ASSERT_RESULT(___) (void)0

#define BUGLY 0

#endif //endif


#define XQLogError(...) [XQLog logError:__VA_ARGS__]
#define XQLogWarn(...) [XQLog logWarn:__VA_ARGS__]

@interface XQLog : NSObject

@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *device;
@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *assertInfo;
@property (strong, nonatomic) NSNumber *time;
@property (strong, nonatomic) NSNumber *level;


+ (void)logLevel:(XQLogLevel)level content:(NSString *)fmt, ...;
+ (void)logLevel:(XQLogLevel)level dict:(NSDictionary *)dict;

+ (void)logWithDict:(NSDictionary *)dict;
+ (void)logVerbose:(NSString *)fmt, ...;
+ (void)logWarn:(NSString *)fmt, ...;
+ (void)logError:(NSString *)fmt, ...;

@end
