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
