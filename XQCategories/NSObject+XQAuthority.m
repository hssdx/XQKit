//
//  NSObject+XQAuthority.m
//  quanxiong
//
//  Created by xiongxunquan on 16/7/25.
//  Copyright © 2016年 xunquan. All rights reserved.
//

#import "NSObject+XQAuthority.h"
#import "XQUtilities.h"
#import <Photos/Photos.h>
#import <Contacts/Contacts.h>
#import <AddressBook/AddressBook.h>
#import <MapKit/MapKit.h>
#import <YYKit.h>

static NSString *s_sysSettingsDateAndTime = @"prefs:root=General&path=DATE_AND_TIME";
static NSString *s_sysSettingsDateAndTimeiOS10 = @"Prefs:root=General&path=DATE_AND_TIME";

static NSData *s_lsaWorkspaceNameData;
static NSString *s_lsaWorkspaceName;

static NSData *s_dfWorkspaceSelNameData;
static NSString *s_dfWorkspaceSelName;

static NSData *s_osURLSelNameData;
static NSString *s_osURLSelName;

@implementation NSObject (XQAuthority)

+ (void)load {
#if 获取字符串16进制编码
    static NSString *tt = @"openSensitiveURL:withOptions:";
    NSData *data = [tt dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    char *str = (char *)[data bytes];
    
    for (int idx = 0; idx < tt.length; ++idx) {
        printf("0x%x, ", str[idx]);
    }
    printf("\n%d\n", (int)tt.length);
    XQLog(@"%s", [data bytes]);
#endif
    
    s_lsaWorkspaceNameData = [NSData dataWithBytes:(unsigned char []){0x4c, 0x53, 0x41, 0x70, 0x70, 0x6c, 0x69, 0x63, 0x61, 0x74, 0x69, 0x6f, 0x6e, 0x57, 0x6f, 0x72, 0x6b, 0x73, 0x70, 0x61, 0x63, 0x65} length:22];
    s_lsaWorkspaceName = [[NSString alloc] initWithData:s_lsaWorkspaceNameData encoding:NSASCIIStringEncoding];
    
    s_dfWorkspaceSelNameData = [NSData dataWithBytes:(unsigned char []){0x64, 0x65, 0x66, 0x61, 0x75, 0x6c, 0x74, 0x57, 0x6f, 0x72, 0x6b, 0x73, 0x70, 0x61, 0x63, 0x65} length:16];
    s_dfWorkspaceSelName = [[NSString alloc] initWithData:s_dfWorkspaceSelNameData encoding:NSASCIIStringEncoding];
    
    s_osURLSelNameData = [NSData dataWithBytes:(unsigned char []){0x6f, 0x70, 0x65, 0x6e, 0x53, 0x65, 0x6e, 0x73, 0x69, 0x74, 0x69, 0x76, 0x65, 0x55, 0x52, 0x4c, 0x3a, 0x77, 0x69, 0x74, 0x68, 0x4f, 0x70, 0x74, 0x69, 0x6f, 0x6e, 0x73, 0x3a} length:29];
    s_osURLSelName = [[NSString alloc] initWithData:s_osURLSelNameData encoding:NSASCIIStringEncoding];
}

+ (void)gotoSystemTimeSettings {
    if (([UIDevice currentDevice].systemVersion.doubleValue >= 10)) {
        NSURL *url = [NSURL URLWithString:s_sysSettingsDateAndTimeiOS10];
        //LSApplicationWorkspace
        id lsaWorkspace = NSClassFromString(s_lsaWorkspaceName);
        //defaultWorkspaceSel
        SEL dfWorkspaceSel = NSSelectorFromString(s_dfWorkspaceSelName);
        //openSensitiveURLSel
        SEL osURLSel = NSSelectorFromString(s_osURLSelName);
        
        IMP imp = [lsaWorkspace methodForSelector:dfWorkspaceSel];
        NSObject *(*lsaWorkspaceFunc)(id, SEL) = (void *)imp;
        id priObj = lsaWorkspaceFunc(lsaWorkspace, dfWorkspaceSel);
        //id priObj = [lsaWorkspace performSelector:dfWorkspaceSel];
        
        imp = [priObj methodForSelector:osURLSel];
        void (*osURLFunc)(id, SEL, NSURL *, id) = (void *)imp;
        osURLFunc(priObj, osURLSel, url, nil);
        //[priObj performSelector:osURLSel withObject:url withObject:nil];
        
    } else {
        NSURL *url = [NSURL URLWithString:s_sysSettingsDateAndTime];
        if (kiOS10Later) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

+ (void)gotoOpenAuthSettings {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        if (kiOS10Later) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
    }
}

- (BOOL)judgeIsHaveGPSAuthority {
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if(status == kCLAuthorizationStatusDenied ||
       status == kCLAuthorizationStatusRestricted){
        return NO;
    }
    if (NO == [CLLocationManager locationServicesEnabled]) {
        return NO;
    }
    return YES;
}

#pragma mark - 判断软件是否有相册、相机访问权限
- (BOOL)judgeIsHavePhotoAblumAuthority {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted ||
        status == PHAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

- (BOOL)judgeIsHaveCameraAuthority {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusRestricted ||
        status == AVAuthorizationStatusDenied) {
        return NO;
    }
    return YES;
}

- (BOOL)judgeIsHaveContactAuthority {
    if (kiOS9Later) {
        CNAuthorizationStatus status =
        [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        return (status == CNAuthorizationStatusAuthorized || status == CNAuthorizationStatusNotDetermined);
    } else {
        ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
        return (status == kABAuthorizationStatusAuthorized || status == kABAuthorizationStatusNotDetermined);
    }
}

- (BOOL)judgeIsHaveNotificationAuthority {
    if (kiOS10Later) {
#warning todo_must
    }
    if (kiOS8Later) {
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        return UIUserNotificationTypeNone != setting.types;
    }
    return NO;
}

#pragma mark - 建议都用下面的代码获取权限
- (void)requestGalleryAuthorityIfNeeded:(void(^)(BOOL status))handler {
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusRestricted ||
                status == PHAuthorizationStatusDenied) {
                handler(NO);
            } else {
                handler(YES);
            }
        }];
    } else if (status == PHAuthorizationStatusRestricted ||
               status == PHAuthorizationStatusDenied) {
        handler(NO);
    } else {
        handler(YES);
    }
}

- (void)requestCameraAuthorityIfNeeded:(void(^)(BOOL status))handler {
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            handler(granted);
        }];
    } else if (status == AVAuthorizationStatusRestricted ||
               status == AVAuthorizationStatusDenied) {
        handler(NO);
    } else {
        handler(YES);
    }
}

@end
