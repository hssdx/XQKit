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
//  XQRoundImageView.m
//  facephoto
//
//  Created by xiongxunquan on 16/6/30.
//  Copyright © 2016年 xunquan. All rights reserved.
//

#import "XQRoundImageView.h"


@interface XQRoundImageView ()
@property (weak, nonatomic) CALayer *shapeLayer;
@end

@implementation XQRoundImageView

- (instancetype)init {
    if (self = [super init]) {
        _round = YES;
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super initWithImage:image]) {
        _round = YES;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        _round = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _round = YES;
        [self applyRoundWithRect:frame];
    }
    return self;
}

- (void)setImage:(UIImage *)image {
    [super setImage:image];
    [self applyRoundWithRect:self.bounds];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self applyRoundWithRect:frame];
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];
    [self applyRoundWithRect:bounds];
}

- (void)applyRoundWithRect:(CGRect)rect {
    if (self.isRound) {
        if (rect.size.width > 1
            && fabs(self.layer.cornerRadius - rect.size.width * 0.5) > 1.
            && fabs(rect.size.width - rect.size.height) < 1) {
            [self addBorderWithColor:[UIColor colorWithWhite:0 alpha:0.15] width:0.5];
        }
    }
}

- (void)setRound:(BOOL)round {
    if (round) {
        [self applyRoundWithRect:self.bounds];
    } else {
        self.layer.masksToBounds = NO;
        self.layer.cornerRadius = 0.;
    }
}

- (void)addBorderWithColor:(UIColor *)color width:(CGFloat)width {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.bounds.size.width * 0.5;
    //禁止离屏渲染
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                    cornerRadius:self.layer.cornerRadius];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.lineWidth = width;
    shapeLayer.fillColor = nil;
    [self.shapeLayer removeFromSuperlayer];
    self.shapeLayer = shapeLayer;
    [self.layer addSublayer:shapeLayer];
    self.contentMode = UIViewContentModeScaleAspectFill;
}
@end
