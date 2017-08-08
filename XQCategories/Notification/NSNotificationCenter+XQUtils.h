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
//  NSNotificationCenter+XQUtils.h
//  xunquan_kit
//
//  Created by quanxiong on 16/6/15.
//  Copyright © 2016年 xxq. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^XQNotificationBlock)(NSNotification * _Nonnull note);

@interface NSNotificationCenter (XQUtils)

/**
 *  post 一个 notification，名称是 class_name + action
 *  通过 xqObserveClass:action:block:  注册监听
 *  注意 在 dealloc 方法中移除监听
 */
- (void)xqNotifyClass:(nullable Class)cls object:(nullable id)object actions:(NSArray<NSString *> * _Nonnull)actions;
- (void)xqNotifyClass:(nullable Class)cls object:(nullable id)object action:(NSString * _Nonnull)action;
- (void)xqNotifyAction:(NSString * _Nonnull)action withObject:(_Nullable id)object;

- (_Nonnull id <NSObject>)xqObserveClass:(nullable Class)cls action:(NSString * _Nonnull)action block:(_Nonnull XQNotificationBlock)block;
- (_Nonnull id <NSObject>)xqObserveAction:(NSString * _Nonnull)action block:(_Nonnull XQNotificationBlock)block;

/**
 *  Model notify - observe
 */
- (void)xqNotifyModel:(_Nonnull id)model action:(NSString * _Nonnull)action;

- (void)xqNotifyModelAdd:(_Nonnull id)model;
- (void)xqNotifyModelUpdate:(_Nonnull id)model;
- (void)xqNotifyModelDelete:(_Nonnull id)model;
- (_Nonnull id <NSObject>)xqObserveClassAdd:(_Nonnull Class)cls block:(_Nonnull XQNotificationBlock)block;
- (_Nonnull id <NSObject>)xqObserveClassUpdate:(_Nonnull Class)cls block:(_Nonnull XQNotificationBlock)block;
- (_Nonnull id <NSObject>)xqObserveClassDelete:(_Nonnull Class)cls block:(_Nonnull XQNotificationBlock)block;
@end
