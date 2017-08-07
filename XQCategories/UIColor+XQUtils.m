//
//  UIColor+XQUtils.m
//  XQ
//
//  Created by xiongxunquan on 16/6/23.
//  Copyright © 2016年 xunquan. All rights reserved.
//
#import "UIColor+XQUtils.h"

#define IMP_COLOR_HEXRGB(_CATEGORY, _NAME, _HEX_RGB) IMP_COLOR_COLOR(_CATEGORY, _NAME, UIColorFromHexRGB(_HEX_RGB))
#define IMP_COLOR_HEXRGBA(_CATEGORY, _NAME, _HEX_RGB, _A) IMP_COLOR_COLOR(_CATEGORY, _NAME, UIColorFromHexRGBA(_HEX_RGB, _A))
#define IMP_COLOR_RGB(_CATEGORY, _NAME, _R, _G, _B) IMP_COLOR_RGBA(_CATEGORY, _NAME, _R, _G, _B, 1)
#define IMP_COLOR_RGBA(_CATEGORY, _NAME, _R, _G, _B, _A) IMP_COLOR_COLOR(_CATEGORY, _NAME, UIColorFromRGBA(_R, _G, _B, _A))
#define IMP_COLOR_COLOR(_CATEGORY, _NAME, _COLOR) + (instancetype)xq##_CATEGORY##_NAME##Color { \
static UIColor *color; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
color = _COLOR; \
}); \
return color; \
}

@implementation UIColor (XQUtils)

IMP_COLOR_HEXRGB(Theme, Background, 0xfede30)
IMP_COLOR_HEXRGB(Theme, Text, 0x3f3f3f)

@end
