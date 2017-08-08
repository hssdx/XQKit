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
//  NSMutableAttributedString+FPUtils.m
//
//  NSMutableAttributedString+XQUtils.m
//  quanxiong
//
//  Created by xiongxunquan on 16/6/21.
//  Copyright © 2016年 xunquan. All rights reserved.
//

#import "NSMutableAttributedString+XQUtils.h"

@implementation NSMutableAttributedString (XQUtils)

+ (instancetype)attributedStringWithContents:(NSArray<NSString *> *)contents
                                      colors:(NSArray<UIColor *> *)colors
                                       fonts:(NSArray<UIFont *> *)fonts {
    return [self attributedStringWithContents:contents colors:colors fonts:fonts urls:nil];
}

+ (instancetype)attributedStringWithContents:(NSArray<NSString *> *)contents
                                      colors:(NSArray<UIColor *> *)colors
                                       fonts:(NSArray<UIFont *> *)fonts
                                        urls:(NSArray<NSString *> *)urls {
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    [contents enumerateObjectsUsingBlock:^(NSString * _Nonnull content, NSUInteger idx, BOOL * _Nonnull stop) {
        UIColor *color;
        if (idx < colors.count) {
            color = [colors objectAtIndex:idx];
        } else {
            color = [colors lastObject];
        }
        UIFont *font;
        if (idx < fonts.count) {
            font = [fonts objectAtIndex:idx];
        } else {
            font = [fonts lastObject];
        }
        NSMutableDictionary *attribute = [@{} mutableCopy];
        if (color) {
            attribute[NSForegroundColorAttributeName] = color;
        }
        if (font) {
            attribute[NSFontAttributeName] = font;
        }
        NSString *url;
        if (idx < urls.count) {
            id obj = [urls objectAtIndex:idx];
            if ([obj isEqual:@0]) {}
            else if ([obj isEqual:@""]) {}
            else if ([obj isEqual:@"0"]) {}
            else if ([obj isEqual:NSNull.null]) {}
            else if (NO == [obj isKindOfClass:NSString.class] &&
                     NO == [obj isKindOfClass:NSURL.class]) {}
            else if ([obj isKindOfClass:NSString.class] && [NSURL URLWithString:obj])
            {
                url = obj;
            }
            else if ([obj isKindOfClass:NSURL.class])
            {
                url = [obj absoluteString];
            }
        }
        if (url) {
            attribute[NSLinkAttributeName] = url;
        }
        NSMutableAttributedString *attrText = [[NSMutableAttributedString alloc] initWithString:content attributes:attribute];
        [result appendAttributedString:attrText];
    }];
    return result;
}

@end
