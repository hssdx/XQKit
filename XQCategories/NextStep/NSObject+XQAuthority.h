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
//  NSObject+XQAuthority.h
//  quanxiong
//
//  Created by xiongxunquan on 16/7/25.
//  Copyright © 2016年 xunquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XQAuthority)

+ (void)xq_gotoSystemTimeSettings;
+ (void)xq_gotoOpenAuthSettings;
- (BOOL)xq_judgeIsHaveGPSAuthority;
- (BOOL)xq_judgeIsHavePhotoAblumAuthority __deprecated;
- (BOOL)xq_judgeIsHaveCameraAuthority __deprecated;
- (BOOL)xq_judgeIsHaveContactAuthority;

- (void)xq_requestRemotePushAuthority:(void(^)(BOOL status))handler;
- (void)xq_requestGalleryAuthorityIfNeeded:(void(^)(BOOL status))handler;
- (void)xq_requestCameraAuthorityIfNeeded:(void(^)(BOOL status))handler;

@end
