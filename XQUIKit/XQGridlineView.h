//
//  XQGridlineView.h
//  XQ
//
//  Created by quanxiong on 16/5/31.
//  Copyright © 2016年 xunquan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XQGridlinePath : NSObject
@property (assign, nonatomic) CGPoint start;
@property (assign, nonatomic) CGPoint end;
@end


@interface XQGridlineView : UIView

@property (readonly, nonatomic, strong) NSMutableArray<XQGridlinePath *> *paths;

/**
 * @brief 网格线宽度，默认为1 pixel (1.0f / [UIScreen mainScreen].scale)
 */
@property (nonatomic, assign) CGFloat gridLineWidth;

/**
 * @brief 网格颜色，默认蓝色
 */
@property (nonatomic, strong) UIColor *gridColor;

- (void)clearPaths;
- (void)moveTo:(CGPoint)start lineTo:(CGPoint)end;
@end
