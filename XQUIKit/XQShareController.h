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
//  XQShareController.h
//  XQKit
//
//  Created by quanxiong on 2017/7/30.
//  Copyright © 2017年 com.xq. All rights reserved.
//

#import "XQPopupControllerBase.h"

@interface WXShareAction : NSObject

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *icon;
@property (copy, nonatomic) void(^handle)(UIView *action);

+ (instancetype)actionWithTitle:(NSString *)title
                           icon:(NSString *)icon
                         handle:(void(^)(UIView *action))handle;

@end



@interface XQShareController : XQPopupControllerBase

+ (instancetype)controllerWithTopic:(NSString *)topic;

- (void)addAction:(WXShareAction *)action;

@end
