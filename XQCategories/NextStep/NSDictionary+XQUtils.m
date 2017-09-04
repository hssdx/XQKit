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
//  NSDictionary+XQUtils.m
//  XQKit
//
//  Created by quanxiong on 2017/9/4.
//  Copyright © 2017年 com.hssdx. All rights reserved.
//

#import "NSDictionary+XQUtils.h"

@implementation NSDictionary (XQUtils)

- (NSString *)GET_URLStringForGET {
    __block NSString *result;
    NSMutableArray *allKeys = [self.allKeys mutableCopy];
    [allKeys sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    [allKeys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
        id obj = [self objectForKey:key];
        NSString *valueStr;
        if ([obj isKindOfClass:NSArray.class]) {
            NSArray *array = obj;
            valueStr = [array componentsJoinedByString:@","];
        } else if ([obj respondsToSelector:@selector(stringValue)]) {
            valueStr = [obj stringValue];
        } else if ([obj isKindOfClass:NSString.class]) {
            valueStr = obj;
        }
        NSString *paraString = [NSString stringWithFormat:@"%@=%@", key, valueStr];
        if (result) {
            result = [result stringByAppendingString:@"&"];
        } else {
            result = @"";
        }
        result = [result stringByAppendingString:paraString];
    }];
    return [self GET_URLStringWithSortType:GET_URLSortNone
                        arrayParaSeparator:nil
                              keyTransform:nil
                            valueTransform:nil];
}

- (NSString *)GET_URLStringWithSortType:(GET_URLSort)sortType
                     arrayParaSeparator:(NSString *)arrayParaSeparator
                           keyTransform:(id<NSCoding>(^)(id<NSCoding> originKey))keyTransform
                         valueTransform:(id (^)(id originValue))valueTransform
{
    __block NSString *result;
    NSMutableArray *allKeys = [self.allKeys mutableCopy];
    if (sortType != GET_URLSortNone) {
        [allKeys sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
            if (sortType == GET_URLSortASC) {
                return [obj1 compare:obj2];
            } else {
                return [obj2 compare:obj1];
            }
        }];
    }
    __block NSString *b_separator = arrayParaSeparator;
    [allKeys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL * _Nonnull stop) {
        id obj = [self objectForKey:key];
        NSString *valueStr;
        if ([obj isKindOfClass:NSArray.class]) {
            if (b_separator.length == 0) {
                b_separator = @",";
            }
            NSArray *array = obj;
            valueStr = [array componentsJoinedByString:b_separator];
        } else if ([obj respondsToSelector:@selector(stringValue)]) {
            valueStr = [obj stringValue];
        } else if ([obj isKindOfClass:NSString.class]) {
            valueStr = obj;
        }
        id transformedKey = key;
        if (keyTransform) {
            transformedKey = keyTransform(key);
        }
        id transformedValue = valueStr;
        if (valueTransform) {
            transformedValue = valueTransform(valueStr);
        }
        NSString *paraString = [NSString stringWithFormat:@"%@=%@", transformedKey, transformedValue];
        if (result) {
            result = [result stringByAppendingString:@"&"];
        } else {
            result = @"";
        }
        result = [result stringByAppendingString:paraString];
    }];
    return result;
}

@end
