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
//  NSObject+XQNotification.h
//  xunquan_kit
//
//  Created by quanxiong on 16/7/3.
//  Copyright © 2016年 xxq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XQNotification)

- (id <NSObject>)xqObserveLoginWithBlock:(void (^)(NSNotification *note))block;
- (id <NSObject>)xqObserveLogoutWithBlock:(void (^)(NSNotification *note))block;
- (id <NSObject>)xqObserveSyncAlbumWithBlock:(void (^)(NSNotification *note))block;
- (id <NSObject>)xqObserveAlbumAddPhotosWithBlock:(void (^)(NSNotification *note))block;

+ (void)xqPostLoginFinished;
+ (void)xqPostLoginFinishedWithObject:(id)object;
+ (void)xqPostLogoutFinished;
+ (void)xqPostLogoutFinishedWithObject:(id)object;

- (void)xqPostLoginFinished;
- (void)xqPostLoginFinishedWithObject:(id)object;
- (void)xqPostLogoutFinished;
- (void)xqPostLogoutFinishedWithObject:(id)object;

//notify
+ (void)xqNotifyAction:(NSString *)action withObject:(id)object;
+ (void)xqNotifyClass:(Class)cls action:(NSString *)action withObject:(id)object;

- (void)xqNotifyAction:(NSString *)action withObject:(id)object;
- (void)xqNotifyClass:(Class)cls action:(NSString *)action withObject:(id)object;

//observe
- (id <NSObject>)xqObserveAction:(NSString *)action block:(void (^)(NSNotification *note))block;

- (void)xqObserveClasses:(NSArray<Class> *)clses action:(NSString *)action block:(void (^)(NSNotification *note))block;
- (id <NSObject>)xqObserveClass:(Class)cls action:(NSString *)action block:(void (^)(NSNotification *note))block;

- (id <NSObject>)xqObserveClassAdd:(Class)cls block:(void (^)(NSNotification *note))block;
- (id <NSObject>)xqObserveClassUpdate:(Class)cls block:(void (^)(NSNotification *note))block;
- (id <NSObject>)xqObserveClassDelete:(Class)cls block:(void (^)(NSNotification *note))block;

- (void)xqSetObserverBlockForKeyPath:(NSString *)keyPath block:(void (^)(__weak id obj, id oldVal, id newVal))block;

- (void)xqRemoveObserversOfAction:(NSString *)action;
- (void)xqRemoveObserversOfClass:(Class)cls;
- (void)xqRemoveAllObservers; //不需要在 dealloc 里调用，会自动调用

@end
