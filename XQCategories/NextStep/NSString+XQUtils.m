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
//  NSString+XQUtils.m
//  XQKit
//
//  Created by quanxiong on 2017/8/25.
//  Copyright © 2017年 xun.quan. All rights reserved.
//

#import "NSString+XQUtils.h"
#import <YYKit/YYKit.h>

@implementation NSString (XQUtils)

- (BOOL)xq_isPhoneNumber {
    static NSString *const kRegexForPhone = @"[\\+ ]?\\d{0,2}?[ -]?[1][345678][0-9][ -]?(\\d{4})[ -]?(\\d{4})";
    
    NSPredicate *regexPhoneNumber =
    [NSPredicate predicateWithFormat:@"SELF MATCHES %@", kRegexForPhone];
    BOOL result = [regexPhoneNumber evaluateWithObject:self];
    return result;
}

- (instancetype)xq_transformToPhone {
    NSString *phone = [[self componentsSeparatedByCharactersInSet:
                        [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                       componentsJoinedByString:@""];
    if ([phone length] > 11){
        phone = [phone substringFromIndex:[phone length]-11];
    }
    return phone;
}

- (instancetype)xq_stringByTrimmingSpecial {
    //除去特殊字符
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:
                           @"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:set];
    return trimmedString;
}

- (instancetype)xq_stringByTrimmingWhitespace {
    //除去空白和换行符字符
    return
    [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)xq_lastChar {
#if DEBUG
    if ([self containsString:@"侯经理"]) {
        NSLog(@"xx");
    }
#endif
    //获取最后一个字符
    if (self.length <= 1) {
        return self;
    }
    //最后一个是 emoji，这个时候，倒数第二个会落在(0xd800 ~ 0xdbff)
    unichar ch = [self characterAtIndex:self.length - 2];
    if (0xd800 <= ch && ch <= 0xdbff) {
        //返回最后2个字符
        return [self substringFromIndex:self.length - 2];
    }
    return [self substringFromIndex:self.length - 1];
}

+ (instancetype)xq_rawUUID {
    NSString *uuid = nil;
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    uuid = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
    if (puuid) {
        CFRelease(puuid);
        puuid = NULL;
    }
    if (uuidString) {
        CFRelease(uuidString);
        uuidString = NULL;
    }
    return uuid;
}

+ (instancetype)xq_rawDeviceId {
    static NSString *const kKeyChainAccount = @"XQKit.Account";
    static NSString *const kKeyChainServiceId = @"XQKit.DeviceId";
    
    NSString *deviceId = [YYKeychain getPasswordForService:kKeyChainServiceId account:kKeyChainAccount];
    if (!deviceId) {
        deviceId = [self xq_rawUUID];
        [YYKeychain setPassword:deviceId forService:kKeyChainServiceId account:kKeyChainAccount];
    }
    return deviceId;
}

@end
