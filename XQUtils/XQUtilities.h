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
//  XQUtilities.h
//  XQ
//
//  Created by quanxiong on 16/6/8.
//  Copyright © 2016年 xunquan. All rights reserved.
//

#import "XQLog.h"

#ifndef XQUtilities_h
#define XQUtilities_h

#pragma mark - HELPER

#define XQRequiredCast(_id, _class) xq_obj_for_class(_id, [_class class])

#define XQTryCast(id, _class) [(id) isKindOfClass:[_class class]] ? ((_class*)id) : nil;

#define XQCFRelease(_V) if (_V) { CFRelease(_V); _V = NULL; }
#define XQCFReleaseOnly(_V) if (_V) { CFRelease(_V);}

#define ASSERT_IS_MAIN_THREAD XQAssert([NSThread isMainThread]);
#define ASSERT_ISNOT_MAIN_THREAD XQAssert(![NSThread isMainThread]);

#define OBJ_CLASS_NAME(_OBJ) NSStringFromClass([_OBJ class])
#define PROP_TO_STRING(_PROP_NAME) NSStringFromSelector(@selector(_PROP_NAME))

#define xq_force_inline __inline__ __attribute__((always_inline))

#pragma mark - keypath define
#ifndef keypath

#define keypath(...) \
metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__))(keypath1(__VA_ARGS__))(keypath2(__VA_ARGS__))

#define keypath1(PATH) \
(((void)(NO && ((void)PATH, NO)), strchr(# PATH, '.') + 1))

#define keypath2(OBJ, PATH) \
(((void)(NO && ((void)OBJ.PATH, NO)), # PATH))

#endif

#pragma mark - app信息
#define APP_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
#define APP_BUILD_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
#define APP_NAME [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]

#define XQ_SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define XQ_SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define XQ_SCREEN_SIZE  [UIScreen mainScreen].bounds.size
#define XQ_SCREEN_BOUNDS  [UIScreen mainScreen].bounds


#define SET_BUTTON_BG_COLOR(_BTN, _COLOR) \
_BTN.reversesTitleShadowWhenHighlighted = YES; \
[_BTN setBackgroundImage:[UIImage imageWithColor:_COLOR] \
forState:UIControlStateNormal]; \
_BTN.layer.masksToBounds = YES;


#define MULTI_PARA_MSG(_MSG,_CONTENT) \
va_list args; \
va_start (args, _MSG); \
NSString *_CONTENT = [[NSString alloc] initWithFormat:_MSG arguments:args]; \
va_end (args);

//YYKit extension
#ifndef kiOS10Later
#define kiOS10Later (kSystemVersion >= 10)
#endif

#define IS_ON_IPHONE    (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_ON_IPAD      (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)



#define IMP_SHARED_INSTANCE \
+ (instancetype)sharedInstance { \
static id instance = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
instance = [[self alloc] init]; \
}); \
return instance; \
}

#define DEF_SHARED_INSTANCE \
+ (instancetype)sharedInstance;

#define xq_force_inline __inline__ __attribute__((always_inline))

// TODO 宏，原文 http://blog.sunnyxx.com/2015/03/01/todo-macro/
#define STRINGIFY(S) #S
#define DEFER_STRINGIFY(S) STRINGIFY(S)
#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))
#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "] " MSG " \n" \
DEFER_STRINGIFY(__FILE__) " line " DEFER_STRINGIFY(__LINE__)
#define KEYWORDIFY try {} @catch (...) {}
// 最终使用下面的宏
#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))


#ifndef XQSYNTH_DUMMY_CLASS
#define XQSYNTH_DUMMY_CLASS(_name_) \
@interface XQSYNTH_DUMMY_CLASS_ ## _name_ : NSObject @end \
@implementation XQSYNTH_DUMMY_CLASS_ ## _name_ @end
#endif

#pragma mark - 全局内联函数
extern void xq_dispatch_main_sync_safe(dispatch_block_t block);
extern void xq_dispatch_main_async_safe(dispatch_block_t block);
extern void xq_dispatch_global_async_if_need(dispatch_block_t block);
extern void xq_dispatch_global_then_dispatch_main_queue(dispatch_block_t global_block, dispatch_block_t main_block);
extern id xq_obj_for_class(id _id, Class cls);

#endif /* XQUtilities_h */

