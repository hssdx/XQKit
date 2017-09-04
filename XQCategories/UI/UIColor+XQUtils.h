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
#import <YYKit/UIColor+YYAdd.h>


#define DEF_COLOR(_CATEGORY, _NAME) +(instancetype)xq##_CATEGORY##_NAME##Color;

#define UIColorFromRGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define UIColorFromRGBA(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]


#define IMP_COLOR_HEX(_CATEGORY, _NAME, _HEX) \
IMP_COLOR_COLOR(_CATEGORY, _NAME, UIColorHex(_HEX))

#define IMP_COLOR_HEXRGBA(_CATEGORY, _NAME, RGB, _ALPHA) \
IMP_COLOR_COLOR(_CATEGORY, _NAME, [UIColor colorWithRGB:RGB alpha:_ALPHA])

#define IMP_COLOR_RGB(_CATEGORY, _NAME, _R, _G, _B) \
IMP_COLOR_RGBA(_CATEGORY, _NAME, _R, _G, _B, 1)

#define IMP_COLOR_RGBA(_CATEGORY, _NAME, _R, _G, _B, _A) \
IMP_COLOR_COLOR(_CATEGORY, _NAME, UIColorFromRGBA(_R, _G, _B, _A))

#define IMP_COLOR_COLOR(_CATEGORY, _NAME, _COLOR) \
+ (instancetype)xq##_CATEGORY##_NAME##Color { \
    static UIColor *color; \
    static dispatch_once_t onceToken; \
    dispatch_once(&onceToken, ^{ \
        color = _COLOR; \
    }); \
    return color; \
}

@interface UIColor (XQUtils)

/* samples
 in UIColor+*.h
 `DEF_COLOR(Theme, Background)`
 
 in UIColor+*.m
 `IMP_COLOR_HEXRGB(Theme, Background, 0xfede30)`
 
 
 valid:
 IMP_COLOR_HEX(AA, BB, 0xaabbcc);
 IMP_COLOR_HEX(AA, CC, #AABBCC);
 IMP_COLOR_HEX(AA, DD, AABBCCDD);
 IMP_COLOR_HEXRGBA(BB, BB, 0xAaBbCc, 0.6)
 */

@end
