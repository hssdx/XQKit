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
//  XQKit.h
//  XQKit
//
//  Created by quanxiong on 2017/8/7.
//  Copyright © 2017年 com.hssdx. All rights reserved.
//

#import <Foundation/Foundation.h>

#if __has_include(<XQKit/XQKit.h>)

FOUNDATION_EXPORT double XQKitVersionNumber;
FOUNDATION_EXPORT const unsigned char XQKitVersionString[];


#import <XQKit/NSArray+XQUtils.h>
#import <XQKit/NSDate+XQUtils.h>
#import <XQKit/NSDictionary+XQUtils.h>
#import <XQKit/NSMutableAttributedString+XQUtils.h>
#import <XQKit/NSObject+XQAuthority.h>
#import <XQKit/NSString+XQUtils.h>
#import <XQKit/NSNotificationCenter+XQUtils.h>
#import <XQKit/NSObject+XQNotification.h>
#import <XQKit/ABPeoplePickerNavigationController+XQUtils.h>
#import <XQKit/CNContactPickerViewController+XQUtils.h>
#import <XQKit/UIApplication+XQUtils.h>
#import <XQKit/UIButton+XQUtils.h>
#import <XQKit/UIColor+XQUtils.h>
#import <XQKit/UIImage+XQUtils.h>
#import <XQKit/UIResponder+XQEventRouter.h>
#import <XQKit/UIView+XQUtils.h>
#import <XQKit/UIViewController+XQHud.h>
#import <XQKit/UIViewController+XQUtils.h>
#import <XQKit/XQGridlineView.h>
#import <XQKit/XQPopupControllerBase.h>
#import <XQKit/XQRoundImageView.h>
#import <XQKit/XQShareController.h>
#import <XQKit/XQConstants.h>
#import <XQKit/XQLog.h>
#import <XQKit/XQToastUtils.h>
#import <XQKit/XQUtilities.h>


#else


#import "NSArray+XQUtils.h"
#import "NSDate+XQUtils.h"
#import "NSDictionary+XQUtils.h"
#import "NSMutableAttributedString+XQUtils.h"
#import "NSObject+XQAuthority.h"
#import "NSString+XQUtils.h"
#import "NSNotificationCenter+XQUtils.h"
#import "NSObject+XQNotification.h"
#import "ABPeoplePickerNavigationController+XQUtils.h"
#import "CNContactPickerViewController+XQUtils.h"
#import "UIApplication+XQUtils.h"
#import "UIButton+XQUtils.h"
#import "UIColor+XQUtils.h"
#import "UIImage+XQUtils.h"
#import "UIResponder+XQEventRouter.h"
#import "UIView+XQUtils.h"
#import "UIViewController+XQHud.h"
#import "UIViewController+XQUtils.h"
#import "XQGridlineView.h"
#import "XQPopupControllerBase.h"
#import "XQRoundImageView.h"
#import "XQShareController.h"
#import "XQConstants.h"
#import "XQLog.h"
#import "XQToastUtils.h"
#import "XQUtilities.h"


#endif


