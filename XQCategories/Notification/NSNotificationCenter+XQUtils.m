//
//  NSNotificationCenter+XQUtils.m
//  xunquan_kit
//
//  Created by quanxiong on 16/6/15.
//  Copyright © 2016年 xxq. All rights reserved.
//

#import "NSNotificationCenter+XQUtils.h"
#import <NSNotificationCenter+YYAdd.h>
#import "XQUtilities.h"

static NSString *const kActionAddName = @"Add";
static NSString *const kActionUpdateName = @"Update";
static NSString *const kActionDeleteName = @"Delete";

@implementation NSNotificationCenter (XQUtils)

- (id <NSObject>)_addObserverForName:(NSString *)name usingBlock:(XQNotificationBlock)block {
    return [self addObserverForName:name object:nil queue:[NSOperationQueue mainQueue] usingBlock:block];
}

- (NSString *)notifyNameWithClass:(Class)cls action:(NSString *)action {
    NSString *result = action;
    if (cls != nil) {
        NSString *className = NSStringFromClass(cls);
        result = [NSString stringWithFormat:@"%@_%@", action, className];
    }
    return result;
}

- (void)xqNotifyClass:(Class)cls object:(id)object actions:(NSArray<NSString *> *)actions {
    [actions enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        [self xqNotifyClass:cls object:object action:obj];
    }];
}

- (void)xqNotifyClass:(Class)cls object:(id)object action:(NSString *)action {
    NSString *notifyName = [self notifyNameWithClass:cls action:action];
    [self postNotificationOnMainThreadWithName:notifyName object:object];
}

- (void)xqNotifyAction:(NSString *)action withObject:(id)object {
    NSString *notifyName = [self notifyNameWithClass:nil action:action];
    [self postNotificationOnMainThreadWithName:notifyName object:object];
}

- (id <NSObject>)xqObserveClass:(Class)cls action:(NSString *)action block:(XQNotificationBlock)block {
    NSString *notifyName = [self notifyNameWithClass:cls action:action];
    return [self _addObserverForName:notifyName usingBlock:block];
}

- (id <NSObject>)xqObserveAction:(NSString *)action block:(XQNotificationBlock)block {
    return [self xqObserveClass:nil action:action block:block];
}

- (NSString *)notifyNameWithObject:(id)object action:(NSString *)action {
    NSString *className;
    if ([object isKindOfClass:NSArray.class]) {
        NSArray *array = object;
        className = OBJ_CLASS_NAME(array.firstObject);
    } else {
        className = OBJ_CLASS_NAME(object);
    }
    return [NSString stringWithFormat:@"%@_%@s", action, className];
}

- (void)xqNotifyModel:(id)model action:(NSString *)action {
    if (!model) {
        return;
    }
    NSArray *objs;
    if ([model isKindOfClass:NSArray.class]) {
        objs = model;
    } else {
        objs = @[model];
    }
    NSString *notifyName = [self notifyNameWithObject:model action:action];
    [self postNotificationOnMainThreadWithName:notifyName object:objs];
}

- (void)xqNotifyModelAdd:(_Nonnull id)model {
    [self xqNotifyModel:model action:kActionAddName];
}

- (void)xqNotifyModelUpdate:(_Nonnull id)model {
    [self xqNotifyModel:model action:kActionUpdateName];
}

- (void)xqNotifyModelDelete:(_Nonnull id)model {
    [self xqNotifyModel:model action:kActionDeleteName];
}

- (id <NSObject>)xqObserveClassAdd:(Class)cls block:(XQNotificationBlock)block {
    return [self xqObserveClass:cls action:kActionAddName block:block];
}

- (id <NSObject>)xqObserveClassUpdate:(Class)cls block:(XQNotificationBlock)block {
    return [self xqObserveClass:cls action:kActionUpdateName block:block];
}

- (id <NSObject>)xqObserveClassDelete:(Class)cls block:(XQNotificationBlock)block {
    return [self xqObserveClass:cls action:kActionDeleteName block:block];
}

@end
