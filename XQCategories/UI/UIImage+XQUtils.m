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
//  UIImage+XQUtils.m
//  XQKit
//
//  Created by quanxiong on 2017/9/1.
//  Copyright © 2017年 xun.quan. All rights reserved.
//

#import "UIImage+XQUtils.h"
#import "NSString+XQUtils.h"
#import <YYKit/YYKit.h>

@implementation UIImage (XQUtils)

+ (instancetype)xq_portraitImageWithColor:(UIColor *)color text:(NSString *)text {
    CGFloat length = 60;
    CGSize size = CGSizeMake(length, length);
    UIFont *font = [UIFont boldSystemFontOfSize:length * 0.5];
    NSDictionary *fontAttributes = @{NSFontAttributeName:font,
                                     NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    return [UIImage xq_imageWithSize:size
                               color:color
                                text:text
                      fontAttributes:fontAttributes];
}

+ (instancetype)xq_imageWithSize:(CGSize)size
                           color:(UIColor *)color
                            text:(NSString *)text
                  fontAttributes:(NSDictionary *)fontAttributes {
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    [color set];
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillEllipseInRect(context, rect);
    
    CGSize textSize = [text sizeWithAttributes:fontAttributes];
    CGFloat x = (size.width - textSize.width) / 2;
    CGFloat y = (size.height - textSize.height) / 2;
    CGRect textRect = CGRectMake(x, y, size.width, size.height);
    [text drawInRect:textRect withAttributes:fontAttributes];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)xq_portraitImageWithName:(NSString *)name {
    static NSArray *s_portraitColors;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        s_portraitColors = @[UIColorHex(0x5F70A7),
                             UIColorHex(0xB58DDC),
                             UIColorHex(0x4EA9EA),
                             UIColorHex(0x17C295),
                             UIColorHex(0x568AAC)];
    });
    NSString *nameKeyword = [name xq_stringByTrimmingWhitespace];
    nameKeyword = [nameKeyword xq_stringByTrimmingSpecial];
    nameKeyword = [nameKeyword xq_lastChar];
    NSInteger idx = name.hash % s_portraitColors.count;
    UIColor *color = s_portraitColors[idx];
    return [UIImage xq_portraitImageWithColor:color text:nameKeyword];
}

@end
