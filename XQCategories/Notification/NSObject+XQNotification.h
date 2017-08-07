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
