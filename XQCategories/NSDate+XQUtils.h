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
