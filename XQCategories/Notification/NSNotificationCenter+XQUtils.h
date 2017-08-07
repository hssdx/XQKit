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
