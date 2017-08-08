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
//  XQGridlineView.h
//  XQ
//
//  Created by quanxiong on 16/5/31.
//  Copyright © 2016年 xunquan. All rights reserved.
//

#import "XQGridlineView.h"

@implementation XQGridlinePath
@end


@interface XQGridlineView () {
    CGFloat _singleLineWidth;
    CGFloat _singleLineAdjustOffset;
    CGFloat _adjustOffset;
}
@property (readwrite, nonatomic, strong) NSMutableArray<XQGridlinePath *> *paths;
@end

@implementation XQGridlineView

@synthesize gridColor = _gridColor;

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
        _gridColor = [UIColor colorWithWhite:0.8 alpha:1.];
        _singleLineWidth = (1 / [UIScreen mainScreen].scale);
        _singleLineAdjustOffset = ((1 / [UIScreen mainScreen].scale) / 2);
        _gridLineWidth = _singleLineWidth;
        _paths = [@[] mutableCopy];
        _adjustOffset = 0;
        if (((int)(_gridLineWidth * [UIScreen mainScreen].scale) + 1) % 2 == 0) {
            _adjustOffset = _singleLineAdjustOffset;
        }
    }
    return self;
}

- (void)setGridColor:(UIColor *)gridColor {
    _gridColor = gridColor;
    [self setNeedsDisplay];
}

- (void)setGridLineWidth:(CGFloat)gridLineWidth {
    _gridLineWidth = gridLineWidth;
    /**
     *  https://developer.apple.com/library/ios/documentation/2DDrawing/Conceptual/DrawingPrintingiOS/GraphicsDrawingOverview/GraphicsDrawingOverview.html
     *  仅当要绘制的线宽为奇数像素时，绘制位置需要调整
     */
    _adjustOffset = 0;
    if (((int)(_gridLineWidth * [UIScreen mainScreen].scale) + 1) % 2 == 0) {
        _adjustOffset = _singleLineAdjustOffset;
    }
    [self setNeedsDisplay];
}

- (void)clearPaths {
    [_paths removeAllObjects];
}

- (void)moveTo:(CGPoint)start lineTo:(CGPoint)end {
    XQGridlinePath *path = [XQGridlinePath new];
    path.start = start;
    path.end = end;
    [_paths addObject:path];
}

- (BOOL)posEqual:(CGFloat)one other:(CGFloat)other {
    if (fabs(one - other) < 0.1) {
        return YES;
    }
    return NO;
}

- (CGFloat)adjustPos:(CGFloat)pos {
    if (pos >= _adjustOffset) {
        return pos - _adjustOffset;
    }
    return _adjustOffset;
}

- (CGPoint)adjustPoint:(CGPoint)point {
    return CGPointMake([self adjustPos:point.x], [self adjustPos:point.y]);
}

- (void)drawRect:(CGRect)rect {
    if (self.paths.count == 0) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    [self.paths enumerateObjectsUsingBlock:^(XQGridlinePath * _Nonnull path, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint start = [self adjustPoint:path.start];
        CGPoint end = [self adjustPoint:path.end];
        CGContextMoveToPoint(context, start.x, start.y);
        CGContextAddLineToPoint(context, end.x, end.y);
    }];
    
    CGContextSetLineWidth(context, self.gridLineWidth);
    CGContextSetStrokeColorWithColor(context, self.gridColor.CGColor);
    CGContextStrokePath(context);
}

@end
