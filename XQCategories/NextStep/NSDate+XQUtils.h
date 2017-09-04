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
//  XQKit
//
//  Created by quanxiong on 2017/7/25.
//  Copyright © 2017年 com.xq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (XQUtils)

/* 2分钟前、1天前、1周前、3个月前、2015年8月6日...
 */
- (NSString *)xq_prettyPassingFormat;
- (NSString *)xq_prettyPassingFormat:(BOOL)showYearIfThisYear;

/* 自动时间戳转换 */
// 1000...(11个0) 是 5138/11/16 17:46:40
// 而 1000...(8个0) 是 1973/3/3 17:46:40
// 因此 5138/11/16 年以后和 1973/3/3 之前 都称为时间盲区
+ (NSTimeInterval)xq_MSTimestamp:(NSTimeInterval)timestamp;
+ (NSNumber *)xq_MSTimestampNumber:(NSNumber *)timestamp;
+ (NSTimeInterval)xq_MSTimestapWithDate:(NSDate *)date;

+ (instancetype)xq_dateWithTimestamp:(NSTimeInterval)timestamp;
+ (instancetype)xq_dateWithNumber:(NSNumber *)number;

+ (NSString *)xq_stringForUTC_ISO;

@end
