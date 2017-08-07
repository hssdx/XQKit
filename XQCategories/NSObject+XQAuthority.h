//
//  NSObject+XQAuthority.h
//  quanxiong
//
//  Created by xiongxunquan on 16/7/25.
//  Copyright © 2016年 xunquan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (XQAuthority)

+ (void)gotoSystemTimeSettings;
+ (void)gotoOpenAuthSettings;
- (BOOL)judgeIsHaveGPSAuthority;
- (BOOL)judgeIsHavePhotoAblumAuthority __deprecated;
- (BOOL)judgeIsHaveCameraAuthority __deprecated;
- (BOOL)judgeIsHaveContactAuthority;
- (BOOL)judgeIsHaveNotificationAuthority;

- (void)requestGalleryAuthorityIfNeeded:(void(^)(BOOL status))handler;
- (void)requestCameraAuthorityIfNeeded:(void(^)(BOOL status))handler;

@end
