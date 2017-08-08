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
//  UIColor+XQUtils.h
//  XQ
//
//  Created by xiongxunquan on 16/6/23.
//  Copyright © 2016年 xunquan. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEF_COLOR(_CATEGORY, _NAME) +(instancetype)xq##_CATEGORY##_NAME##Color;

#define UIColorFromRGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define UIColorFromRGBA(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define UIColorFromHexRGB(rgbValue) [UIColor colorWithRed:\
((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:\
((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:\
((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromHexRGBA(rgbValue,alphaValue) [UIColor colorWithRed:\
((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:\
((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:\
((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

@interface UIColor (XQUtils)

DEF_COLOR(Theme, Background)
DEF_COLOR(Theme, Text)

@end
