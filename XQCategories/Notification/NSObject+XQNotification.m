//
//  NSObject+XQNotification.m
//  xunquan_kit
//
//  Created by quanxiong on 16/7/3.
//  Copyright © 2016年 xxq. All rights reserved.
//


#import "NSNotificationCenter+XQUtils.h"
#import "NSObject+YYAddForKVO.h"
#import "XQUtilities.h"
#import "XQLog.h"
#import <objc/runtime.h>

static NSString *const kLoginFinishedNotification = @"kLoginFinishedNotification";
static NSString *const kLogoutFinishedNotification = @"kLogoutFinishedNotification";

static const int observers_key;

@interface _XQ_Observers : NSObject

@property (strong, nonatomic) NSMutableArray<id<NSObject>> *observers;

@end

@implementation _XQ_Observers

- (instancetype)init {
    if (self = [super init]) {
        _observers = [NSMutableArray array];
    }
    return self;
}

- (void)dealloc {
    [self xqRemoveAllObservers];
}

- (void)addObserver:(id<NSObject>)observer {
    [self.observers addObject:observer];
}

- (void)xqRemoveObserversOfAction:(NSString *)action {
    NSMutableArray<id<NSObject>> * observers = self.observers;
    for (NSInteger idx = observers.count - 1; idx >= 0; --idx) {
        id observer = observers[idx];
        NSString *notifyName = [observer valueForKey:@"name"];
        if ([notifyName hasSuffix:action]) {
            [[NSNotificationCenter defaultCenter] removeObserver:observer];
            [observers removeObjectAtIndex:idx];
#if 0
            XQLog(@">>Remove Notify of[%@] - [%@][%@]"
                  , className
                  , OBJ_CLASS_NAME(self)
                  , notifyName);
#endif
        }
    }
}

- (void)xqRemoveObserversOfClass:(Class)cls {
    NSString *className = NSStringFromClass(cls);
    NSString *classesName = [className stringByAppendingString:@"s"];
    
    NSMutableArray<id<NSObject>> * observers = self.observers;
    for (NSInteger idx = observers.count - 1; idx >= 0; --idx) {
        id observer = observers[idx];
        NSString *notifyName = [observer valueForKey:@"name"];
        if ([notifyName hasSuffix:className]
            || [notifyName hasSuffix:classesName]) {
            [[NSNotificationCenter defaultCenter] removeObserver:observer];
            [observers removeObjectAtIndex:idx];
#if 0
            XQLog(@">>Remove Notify of[%@] - [%@][%@]"
                  , className
                  , OBJ_CLASS_NAME(self)
                  , notifyName);
#endif
        }
    }
}

- (void)xqRemoveAllObservers {
    NSMutableArray<id<NSObject>> * observers = self.observers;
    dispatch_apply(observers.count,
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                   ^(size_t idx) {
#if DEBUG
                       id observer = observers[idx];
                       XQLog(@">>%s %@", __func__, [observer valueForKey:@"name"]);
#endif
                       [[NSNotificationCenter defaultCenter] removeObserver:observers[idx]];
                   });
#if DEBUG
    if (observers.count > 0) {
        XQLog(@">>Remove Notify over.[%@][%d]"
              , OBJ_CLASS_NAME(self)
              , (int)observers.count);
    }
#endif
    [observers removeAllObjects];
}

@end

@implementation NSObject (XQUtils)

#pragma mark - 定制方法

- (id <NSObject>)xqObserveLoginWithBlock:(void (^)(NSNotification *note))block {
    id<NSObject> observer = [self xqObserveAction:kLoginFinishedNotification block:block];
    [self.xqNotifyCenterObservers addObserver:observer];
    return observer;
}

- (id <NSObject>)xqObserveLogoutWithBlock:(void (^)(NSNotification *note))block {
    id<NSObject> observer = [self xqObserveAction:kLogoutFinishedNotification block:block];
    [self.xqNotifyCenterObservers addObserver:observer];
    return observer;
}

#pragma mark - 定制 notify
+ (void)xqPostLoginFinished {
    [self xqPostLoginFinishedWithObject:nil];
}

+ (void)xqPostLoginFinishedWithObject:(id)object {
    [self xqNotifyAction:kLoginFinishedNotification withObject:object];
}

+ (void)xqPostLogoutFinished {
    [self xqPostLogoutFinishedWithObject:nil];
}

+ (void)xqPostLogoutFinishedWithObject:(id)object {
    [self xqNotifyAction:kLogoutFinishedNotification withObject:object];
}

+ (void)xqPostSyncAlbumNow {
    [self _triggerSyncNotification:nil];
}

+ (void)xqPostSyncAlbumDelay:(NSTimeInterval)delay {
    xq_dispatch_main_sync_safe(^{
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_triggerSyncNotification:) object:nil];
        [self performSelector:@selector(_triggerSyncNotification:) withObject:nil afterDelay:delay];
    });
}

- (void)xqPostLoginFinished {
    [self.class xqPostLoginFinished];
}

- (void)xqPostLoginFinishedWithObject:(id)object {
    [self.class xqPostLoginFinishedWithObject:object];
}

- (void)xqPostLogoutFinished {
    [self.class xqPostLogoutFinished];
}

- (void)xqPostLogoutFinishedWithObject:(id)object {
    [self.class xqPostLogoutFinishedWithObject:object];
}

- (void)xqPostAlbumAddPhotosWithObject:(id)object {
    [self.class xqPostAlbumAddPhotosWithObject:object];
}

- (void)_triggerSyncNotification:(id)sender {
    [self.class _triggerSyncNotification:sender];
}

- (void)xqPostSyncAlbumNow {
    [self.class xqPostSyncAlbumNow];
}

- (void)xqPostSyncAlbumDelay:(NSTimeInterval)delay {
    [self.class xqPostSyncAlbumDelay:delay];
}

#pragma mark - meta
#pragma mark static
+ (void)xqNotifyAction:(NSString *)action withObject:(id)object {
    [[NSNotificationCenter defaultCenter] xqNotifyAction:action withObject:object];
}

+ (void)xqNotifyClass:(Class)cls action:(NSString *)action withObject:(id)object {
    [[NSNotificationCenter defaultCenter] xqNotifyClass:cls object:object action:action];
}

- (void)xqNotifyAction:(NSString *)action withObject:(id)object {
    [self.class xqNotifyAction:action withObject:object];
}

- (void)xqNotifyClass:(Class)cls action:(NSString *)action withObject:(id)object {
    [self.class xqNotifyClass:cls action:action withObject:object];
}

- (void)xqObserveClasses:(NSArray<Class> *)clses action:(NSString *)action block:(void (^)(NSNotification *note))block {
    [clses enumerateObjectsUsingBlock:^(Class  _Nonnull cls, NSUInteger idx, BOOL * _Nonnull stop) {
        id<NSObject> observer =
        [[NSNotificationCenter defaultCenter] xqObserveClass:cls
                                                    action:action
                                                     block:block];
        [self.xqNotifyCenterObservers addObserver:observer];
    }];
}

- (id <NSObject>)xqObserveAction:(NSString *)action block:(void (^)(NSNotification *note))block {
    id<NSObject> observer =
    [[NSNotificationCenter defaultCenter] xqObserveAction:action block:block];
    [self.xqNotifyCenterObservers addObserver:observer];
    return observer;
}

- (id <NSObject>)xqObserveClass:(Class)cls action:(NSString *)action block:(void (^)(NSNotification *note))block {
    id<NSObject> observer =
    [[NSNotificationCenter defaultCenter] xqObserveClass:cls
                                                action:action
                                                 block:block];
    [self.xqNotifyCenterObservers addObserver:observer];
    return observer;
}

- (id <NSObject>)xqObserveClassAdd:(Class)cls block:(void (^)(NSNotification *note))block {
    id<NSObject> observer =
    [[NSNotificationCenter defaultCenter] xqObserveClassAdd:cls block:block];
    [self.xqNotifyCenterObservers addObserver:observer];
    return observer;
}

- (id <NSObject>)xqObserveClassUpdate:(Class)cls block:(void (^)(NSNotification *note))block {
    id<NSObject> observer =
    [[NSNotificationCenter defaultCenter] xqObserveClassUpdate:cls block:block];
    [self.xqNotifyCenterObservers addObserver:observer];
    return observer;
}

- (id <NSObject>)xqObserveClassDelete:(Class)cls block:(void (^)(NSNotification *note))block {
    id<NSObject> observer =
    [[NSNotificationCenter defaultCenter] xqObserveClassDelete:cls block:block];
    [self.xqNotifyCenterObservers addObserver:observer];
#if DEBUG
    id obj = observer;
    XQLog(@">>%s %@", __func__, [obj valueForKey:@"name"]);
#endif
    return observer;
}

- (_XQ_Observers *)xqNotifyCenterObservers {
    _XQ_Observers *observers = objc_getAssociatedObject(self, &observers_key);
    if (!observers) {
        observers = [_XQ_Observers new];
        objc_setAssociatedObject(self, &observers_key, observers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return observers;
}

- (void)xqSetObserverBlockForKeyPath:(NSString *)keyPath block:(void (^)(__weak id obj, id oldVal, id newVal))block {
    if (!keyPath || !block) return;
    [self removeObserverBlocksForKeyPath:keyPath];
    [self addObserverBlockForKeyPath:keyPath block:block];
}

- (void)xqRemoveObserversOfAction:(NSString *)action {
    [[self xqNotifyCenterObservers] xqRemoveObserversOfAction:action];
}

- (void)xqRemoveObserversOfClass:(Class)cls {
    [[self xqNotifyCenterObservers] xqRemoveObserversOfClass:cls];
}

- (void)xqRemoveAllObservers {
    [[self xqNotifyCenterObservers] xqRemoveAllObservers];
}

@end
