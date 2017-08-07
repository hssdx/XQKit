//
//  NSMutableAttributedString+XQUtils.h
//  quanxiong
//
//  Created by xiongxunquan on 16/6/21.
//  Copyright © 2016年 xunquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (XQUtils)

+ (instancetype)attributedStringWithContents:(NSArray<NSString *> *)contents
                                      colors:(NSArray<UIColor *> *)colors
                                       fonts:(NSArray<UIFont *> *)fonts;

+ (instancetype)attributedStringWithContents:(NSArray<NSString *> *)contents
                                      colors:(NSArray<UIColor *> *)colors
                                       fonts:(NSArray<UIFont *> *)fonts
                                        urls:(NSArray<NSString *> *)urls;

@end
