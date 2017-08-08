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
//  NSDate+XQUtils.m
//  IKSarahah
//
//  Created by quanxiong on 2017/7/25.
//  Copyright © 2017年 com.xq. All rights reserved.
//

#import "NSDate+XQUtils.h"
#import <YYKit.h>

@implementation NSDate (XQUtils)

+ (NSDateFormatter *)sharedDateFormatter {
    static NSDateFormatter *kSharedDateFormatterInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kSharedDateFormatterInstance = [[NSDateFormatter alloc] init];
        kSharedDateFormatterInstance.timeStyle = NSDateFormatterMediumStyle;
    });
    return kSharedDateFormatterInstance;
}

+ (NSTimeInterval)xqOneMinute {
    return 60;
}

+ (NSTimeInterval)xqOneHour {
    return 60 * [self xqOneMinute];
}

+ (NSTimeInterval)xqOneDay {
    return 24 * [self xqOneHour];
}

+ (NSTimeInterval)xqSomeDay:(NSInteger)day {
    return day * [self xqOneDay];
}

+ (NSTimeInterval)xqOneWeek {
    return 7 * [self xqOneDay];
}

+ (NSTimeInterval)xqDiffTimestampFromNow:(NSDate *)date {
    NSTimeInterval diffTime = NSDate.date.timeIntervalSince1970 - date.timeIntervalSince1970;
    return diffTime;
}

- (NSString *)xqPrettyPassingFormat {
    return [self xqPrettyPassingFormat:NO];
}

- (NSString *)xqPrettyPassingFormat:(BOOL)showYearIfThisYear {
    NSTimeInterval diffTimestamp = [NSDate xqDiffTimestampFromNow:self];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    NSDate *diffDate = [NSDate dateWithTimeIntervalSince1970:diffTimestamp - timeZone.secondsFromGMT];
    NSString *format;
    if (diffTimestamp < [NSDate xqOneMinute]) {
        format = [NSString stringWithFormat:@"%d秒钟前", (int)diffDate.second];
    } else if (diffTimestamp < [NSDate xqOneHour]) {
        format = [NSString stringWithFormat:@"%d分钟前", (int)diffDate.minute];
    } else if (diffTimestamp < [NSDate xqOneDay]) {
        format = [NSString stringWithFormat:@"%d小时前", (int)diffDate.hour];
    } else if (diffTimestamp < [NSDate xqOneWeek]) {
        format = [NSString stringWithFormat:@"%d天前", (int)diffDate.day];
    } else {
        if (showYearIfThisYear || (NSDate.date.year != self.year)) {
            format = @"yyyy年M月d日";
        } else {
            format = @"M月d日";
        }
    }
    NSDateFormatter *dateFormatter = [self.class sharedDateFormatter];
    dateFormatter.dateFormat = format;
    return [dateFormatter stringFromDate:self];
}


+ (NSTimeInterval)xq_safe_server_timestamp:(NSTimeInterval)timestamp {
    // 1000...(11个0) 是 5138/11/16 17:46:40
    // 而 1000...(8个0) 是 1973/3/3 17:46:40
    // 因此 5138/11/16 年以后和 1973/3/3 之前 都被视为时间盲区
    if(timestamp > 100000000000) {
        return timestamp;
    }
    return timestamp * 1000.;
}

+ (NSNumber *)xq_safe_server_timestamp_number:(NSNumber *)timestamp {
    return @([self xq_safe_server_timestamp:timestamp.doubleValue]);
}

+ (NSDate *)xq_date_with_timestamp:(NSTimeInterval)timestamp {
    // 1000...(11个0) 是 5138/11/16 17:46:40
    // 而 1000...(8个0) 是 1973/3/3 17:46:40
    // 因此 5138/11/16 年以后和 1973/3/3 之前 都被视为时间盲区
    if(timestamp > 100000000000) {
        timestamp = timestamp * 0.001;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    return date;
}

+ (NSDate *)xq_date_with_number:(NSNumber *)number {
    if (!number) {
        return nil;
    }
    return [self xq_date_with_timestamp:number.doubleValue];
}

+ (NSTimeInterval)xq_mm_timestap_with_date:(NSDate *)date {
    return date.timeIntervalSince1970 * 1000.;
}

@end
