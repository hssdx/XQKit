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
//  NSMutableAttributedString+XQUtils.h
//  quanxiong
//
//  Created by xiongxunquan on 16/6/21.
//  Copyright © 2016年 xunquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (XQUtils)

/*
 valid:
 [NSMutableAttributedString xq_attributedStringWithContents:@[@"你",@"很",@"帅"]
                                                     colors:@[UIColor.redColor,
                                                              UIColor.greenColor,
                                                              UIColor.blueColor]
                                                      fonts:@[@12, @18, @12]];
 
 [NSMutableAttributedString xq_attributedStringWithContents:@[@"你",@"很",@"帅"]
                                                     colors:@[UIColor.redColor,
                                                              UIColor.greenColor,
                                                              UIColor.blueColor]
                                                      fonts:@[@12, @18, @12]
                                                       urls:@[@"", @"http://www.shuai.com/"]];
 
 ## Attention the `urls` parameter, the count not equal `contents`, the same as `colors` and `fonts`;
 ## Attention the `fonts`, you can use `NSNumber` or `UIFont`;
 
 */

+ (instancetype)xq_attributedStringWithContents:(NSArray<NSString *> *)contents
                                         colors:(NSArray<UIColor *> *)colors
                                          fonts:(NSArray<UIFont *> *)fonts;

+ (instancetype)xq_attributedStringWithContents:(NSArray<NSString *> *)contents
                                         colors:(NSArray<UIColor *> *)colors
                                          fonts:(NSArray<UIFont *> *)fonts
                                           urls:(NSArray<NSString *> *)urls;

@end
