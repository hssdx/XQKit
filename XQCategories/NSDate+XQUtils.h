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
//  NSDate+XQUtils.h
//  IKSarahah
//
//  Created by quanxiong on 2017/7/25.
//  Copyright © 2017年 com.xq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XQUtils)

- (NSString *)xqPrettyPassingFormat;
- (NSString *)xqPrettyPassingFormat:(BOOL)showYearIfThisYear;

+ (NSTimeInterval)xq_safe_server_timestamp:(NSTimeInterval)timestamp;
+ (NSNumber *)xq_safe_server_timestamp_number:(NSNumber *)timestamp;

+ (NSDate *)xq_date_with_timestamp:(NSTimeInterval)timestamp;
+ (NSDate *)xq_date_with_number:(NSNumber *)number;
+ (NSTimeInterval)xq_mm_timestap_with_date:(NSDate *)date;

@end
